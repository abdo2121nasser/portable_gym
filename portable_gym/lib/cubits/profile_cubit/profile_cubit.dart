import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_coach/resourses/models/profile_models/profile_model.dart';
import 'package:my_coach/screens/app_bar_screens/setting_screen/setting_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/app_bar_blocks/log_out_bottom_sheet_block.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../screens/authentication_screens/login_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  bool isProfileLowerBlock = false;
  late final String userDocId;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  var pickedFilename;
  File? imageFile;
  String imageLink = '';
  ProfileModel? profileModel;

  getUserDocId() async {
    emit(GetUserDocIdLoadingState());
    await const FlutterSecureStorage()
        .read(key: StringManager.userDocId)
        .then((value) {
          if(value!=null) {
            userDocId = value;
            emit(GetUserDocIdSuccessState());
          }
    }).then((value) {
      if(userDocId==null)
        {
          Get.offAll(const LoginScreen());
          return;
        }
      else
        {
          getUserData();
        }
    }).catchError((error) {
      emit(GetUserDocIdErrorState());
      Get.offAll(const LoginScreen());
      debugPrint(error.toString());

    });
  }


  getProfileOptionsLables({
    required context,
  }) {
    return [
      S.of(context).myProfile,
      S.of(context).settings,
      S.of(context).logout,
    ];
  }

  getProfileOptionsIcons() {
    return [Icons.person, Icons.settings, Icons.logout_outlined];
  }

  profileScreenNavigation(
      {required int index, bool isAppBar = false, context}) {
    if (isAppBar == true && isProfileLowerBlock == true) {
      isProfileLowerBlock = false;
      emit(ChangeToProfileScreenBlockState());
    } else if (isAppBar == true && isProfileLowerBlock == false) {
      Get.back();
    } else if (index == 0 && isAppBar == false) {
      isProfileLowerBlock = true;
      emit(ChangeToProfileLowerBlockState());
    } else if (index == 2) {
      showLogOutBottomSheet(context);
    } else if (index == 1) {
      Get.to(() => SettingScreen(
            profCubit: ProfileCubit.get(context),
          ));
    }
  }

  getProfileControllers() {
    return [
      fullNameController,
      nickNameController,
      emailController,
      phoneController,
      ageController,
      weightController,
      heightController,
    ];
  }

  getProfileInputsLables({required context}) {
    return [
      S.of(context).fullName,
      S.of(context).nickName,
      S.of(context).email,
      S.of(context).phone,
      S.of(context).age,
      S.of(context).weight,
      S.of(context).height,
    ];
  }

  setProfileControllers({required ProfileModel tempModel}) {
    fullNameController.text = tempModel.fullName;
    nickNameController.text = tempModel.nickName;
    emailController.text = tempModel.email;
    phoneController.text = tempModel.phone;
    ageController.text = tempModel.age.toString();
    weightController.text = tempModel.weight.toString();
    heightController.text = tempModel.height.toString();
    imageLink = tempModel.imageLink;

    emit(SetProfileControllersValuesState());
  }

  void showLogOutBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (ctx) => const LogOutBottomSheetBlock());
  }

  Future<void> pickImage() async {
    emit(PickImageLoadingState());
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedFilename = pickedFile.path.split('/').last;
      imageFile = File(pickedFile.path);
      emit(PickImageSuccessState());
    } else {
      emit(PickImageErrorState());
      debugPrint('no image selected');
    }
  }

  Future<void> deleteImageOnCloud({required String imageUrl}) async {
    emit(DeleteImageFileOnCloudLoadingState());
    await FirebaseStorage.instance.refFromURL(imageUrl).delete().then((value) {
      emit(DeleteImageFileOnCloudSuccessState());
    }).catchError((error) {
      emit(DeleteImageFileOnCloudErrorState());
    });
  }

  Future<void> uploadImage() async {
    emit(UploadImageFileLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child(imageFile!.path)
        .putFile(imageFile!)
        .then((result) async {
      imageLink = await result.ref.getDownloadURL();
      emit(UploadImageFileSuccessState());
    }).catchError((error) {
      emit(UploadImageFileErrorState());
      debugPrint(error);
    });
  }

  Future<void> updateImageOnCloud() async {
    await Future.delayed(const Duration(seconds: 0)).then((value) async {
      await deleteImageOnCloud(imageUrl: imageLink);
    }).then((value) async {
      await uploadImage();
    }).catchError((error) {
      debugPrint(error);
    });
  }

//------------------------setUp functions---------------------------------
  getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(userDocId)
        .get()
        .then((value) async {
      String? currentDeviceToken = await FirebaseMessaging.instance.getToken();
      String? profileDeviceToken=value.data()![StringManager.deviceToken]??'';
      if ( profileDeviceToken  != currentDeviceToken) {
        await updateDeviceToken(userDocId: value.id,deviceToken: currentDeviceToken!);
        value.data()![StringManager.deviceToken]=currentDeviceToken;
      }
      profileModel =
          ProfileModel.fromJson(json: value.data()!, docId: value.id);

      emit(GetUserDataSuccessState());
      setProfileControllers(tempModel: profileModel!);
    }).catchError((error) {
      emit(GetUserDataErrorState());
      debugPrint(error.toString());
    });
  }

  Future<void> editUserData() async {
    emit(UpdateUserDataLoadingState());
    if (imageFile != null) {
      await updateImageOnCloud();
    }
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(profileModel!.docId)
        .update({
      StringManager.userFullName: fullNameController.text,
      StringManager.userNickName: nickNameController.text,
      StringManager.userPhone: phoneController.text,
      StringManager.userAge: int.parse(ageController.text),
      StringManager.userHeight: int.parse(heightController.text),
      StringManager.userWeight: int.parse(weightController.text),
      StringManager.userImageLink: imageLink,
    }).then((value) async {
      imageFile = null;
      imageLink = '';
      emit(UpdateUserDataSuccessState());
     await getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
      debugPrint(error);
    });
  }

  Future<void> editUserQuestionAnswers(
      {required Map<String, dynamic> questionsMap}) async {
    emit(UpdateUserQuestionAnswerLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(profileModel!.docId)
        .update({StringManager.profileQuestionsAnswer: questionsMap}).then(
            (value) async {
      emit(UpdateUserQuestionAnswerSuccessState());
     await getUserData();
    }).catchError((error) {
      emit(UpdateUserQuestionAnswerErrorState());
      debugPrint(error);
    });
  }

  Future<void> updateDeviceToken({required String userDocId,required String deviceToken}) async {
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(userDocId)
        .update({StringManager.deviceToken: deviceToken})
        .then((value) {
    })
        .catchError((error) {
          debugPrint(error);
        });
  }
}
