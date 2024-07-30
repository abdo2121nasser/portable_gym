import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../firebase_options.dart';
import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.email}) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  bool isProfileLowerBlock = false;
  String email;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  var pickedFilename;
  File? imageFile;
  String imageLink='';  ProfileModel? profileModel;

  getProfileOptions({required context, required int index}) {
    List<String> profileOptionsLables = [
      S.of(context).myProfile,
      S.of(context).settings,
      S.of(context).logout,
    ];
    return profileOptionsLables[index];
  }

  profileScreenNavigation(
      {required int index, bool isAppBar = false, context}) {
    if (isAppBar == true && isProfileLowerBlock == true) {
      isProfileLowerBlock = false;
      emit(ChangeToProfileScreenBlockState());
    } else if (isAppBar == true && isProfileLowerBlock == false) {
      Navigator.pop(context);
    } else if (index == 0 && isAppBar == false) {
      isProfileLowerBlock = true;
      emit(ChangeToProfileLowerBlockState());
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
  setProfileControllers() {
   fullNameController.text= profileModel!.fullName;
   nickNameController.text= profileModel!.nickName;
   emailController.text= profileModel!.email;
   phoneController.text= profileModel!.phone;
   ageController.text= profileModel!.age.toString();
   weightController.text= profileModel!.weight.toString();
   heightController.text= profileModel!.height.toString();
   imageLink= profileModel!.imageLink;
    emit(SetProfileControllersValuesState());
  }
  //todo setting screen is not made
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
  Future<void> updateImageOnCloud() async {
    emit(UpdateImageFileOnCloudLoadingState());

    await FirebaseStorage.instance.ref().child(profileModel!.imageLink)
         .putFile(imageFile!)
               .then((value) async {
                 //profileModel!.imageLink!=await value.ref.getDownloadURL();
                 emit(UpdateImageFileOnCloudSuccessState());

           })
               .catchError((error){
             emit(UpdateImageFileOnCloudErrorState());

             debugPrint(error);
           });

  }
//------------------------setUp functions---------------------------------
  getUserData() async {
   emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).where(StringManager.userEmail,isEqualTo:email ).get()
        .then((value) async {
         profileModel= ProfileModel.fromJson(json: value.docs[0].data(),docId: value.docs[0].id);
         emit(GetUserDataSuccessState());
         setProfileControllers();
    }).catchError((error){
      emit(GetUserDataErrorState());
               debugPrint(error);
    });
  }

  editUserData() async {
    // if(imageFile!=null) {
    //   await updateImageOnCloud();
    // }
   emit(UpdateUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).doc(profileModel!.docIc)
        .update({
      StringManager.userFullName: fullNameController.text,
      StringManager.userNickName: nickNameController.text,
      StringManager.userPhone: phoneController.text,
      StringManager.userAge: int.parse(ageController.text),
      StringManager.userHeight: int.parse(heightController.text),
      StringManager.userWeight: int.parse(weightController.text),
    //  StringManager.userImageLink:imageLink,
    }).then((value)   {

      // imageFile=null;
      // imageLink='';
      emit(UpdateUserDataSuccessState());
       getUserData();
    }).catchError((error){
      emit(UpdateUserDataErrorState());
               debugPrint(error);
    });
  }



}
