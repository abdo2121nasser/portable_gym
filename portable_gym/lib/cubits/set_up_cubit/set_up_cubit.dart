import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/activity_level_set_up_block.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/age_set_up_block.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/fill_profile_set_up_block.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/gender_set_up_block.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/goal_set_up_block.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/height_set_up_block.dart';
import '../../resourses/blocks/set_up_blocks/set_up_bodies_blocks/weight_set_up_block.dart';

import '../../resourses/managers_files/enum_manager.dart';
import '../../resourses/managers_files/string_manager.dart';

part 'set_up_state.dart';

class SetUpCubit extends Cubit<SetUpState> {
  SetUpCubit({required String email}) : super(SetUpInitial()) {
    this.email.text = email;
  }

  static SetUpCubit get(context) => BlocProvider.of(context);
  int currentPageBodyIndex = 0;
  RulerPickerController weightController = RulerPickerController(value: 60);
  WeightSliderController heightController = WeightSliderController(
      initialWeight: 160, minWeight: 0, interval: 1, maxWeight: 220);

  int age = 31;
  int weight = 60;
  int height = 160;
  Gender gender = Gender.male;
  List<String> activityLevels = [
    StringManager.bodyCategoryLevelBeginner,
    StringManager.bodyCategoryLevelIntermediate,
    StringManager.bodyCategoryLevelAdvanced,
  ];
  int currentActivityLevel = 0;

  TextEditingController nickName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  //-------------------------------------------------
  //----------------------------------------------
  var pickedFilename;
  File? imageFile;
  String imageLink='';
  //------------------------------------------
  List<Widget> getPageBody({required SetUpCubit setUpCubit}) {
    return [
      const GenderSetUpBlock(),
      AgeSetUpBlock(),
      WeightSetUpBlock(),
      HeightSetUpBlock(),
      GoalSetUpBlock(),
      ActivityLevelSetUpBlock(),
      FillProfileSetUpBlock(
        setCubit: setUpCubit,
      )
    ];
  }

  incrementPageBodyIndex() {
    currentPageBodyIndex++;
    emit(IncrementPageBodyIndexState());
  }

  decrementPageBodyIndex() {
    currentPageBodyIndex--;
    emit(DecrementPageBodyIndexState());
  }

  setUpForwardNavigation({required context}) {
    if (currentPageBodyIndex == 6) {
      createProfileProcess(context: context);
    } else {
      incrementPageBodyIndex();
    }
  }

  setUpBackWardNavigation({required context}) {
    if (currentPageBodyIndex == 0) {
      Get.back();
    } else {
      decrementPageBodyIndex();
    }
  }

  String getTitle({required context}) {
    switch (currentPageBodyIndex) {
      case 0:
        return S.of(context).whatsYourGender;
      case 1:
        return S.of(context).howOldAreYou;
      case 2:
        return S.of(context).whatsYourWeight;
      case 3:
        return S.of(context).whatsYourHeight;
      case 4:
        return S.of(context).whatsYourGoal;
      case 5:
        return S.of(context).physicalActivityLevel;
      case 6:
        return S.of(context).fillYourProfile;
    }
    return '';
  }

  String getButtonText({required context}) {
    if (currentPageBodyIndex != 6) {
      return S.of(context).continued;
    } else {
      return S.of(context).start;
    }
  }

  Color getButtonColor({required context}) {
    if (currentPageBodyIndex != 6) {
      return ColorManager.kBlackColor;
    } else {
      return ColorManager.kLimeGreenColor;
    }
  }

  Color getTextColor({required context}) {
    if (currentPageBodyIndex != 6) {
      return ColorManager.kWhiteColor;
    } else {
      return ColorManager.kBlackColor;
    }
  }

  List<String> getPhysicalActivity({required context}) {
    return [
      S.of(context).beginner,
      S.of(context).intermediate,
      S.of(context).advanced,
    ];
  }

  changeCurrentActivityLevel({required int index}) {
    currentActivityLevel = index;
    emit(ChangeActivityLevelState());
  }

  getAge({required int age}) {
    this.age = age;
    emit(GetAgeState());
  }

  getWeight({required int weight}) {
    this.weight = weight;
    emit(GetWeightState());
  }

  getHeight({required int height}) {
    this.height = height;
    emit(GetHeightState());
  }

  changeGender({required Gender gender}) {
    this.gender = gender;
    emit(ChangeGenderState());
  }

  getFillProfileInputsLables({
    required context,
  }) {
    return [
      S.of(context).fullName,
      S.of(context).nickName,
      S.of(context).email,
      S.of(context).phone,
    ];
  }

  getFillProfileInputControllers({
    required context,
  }) {
    return [fullName, nickName, email, phone];
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
      print('no image selected');
      emit(PickImageErrorState());
    }
  }
  uploadImage() async{
    emit(UploadImageFileLoadingState());
 await  FirebaseStorage.instance.ref().child('${imageFile!.path}')
       .putFile(imageFile!).
    then((result) async {
    imageLink = await result.ref.getDownloadURL().toString();
      emit(UploadImageFileSuccessState());
    }).catchError((error){
     emit(UploadImageFileErrorState());
     // debugPrint(error);
    });
  }
  //------------------------profile--------------------------------------------

  String nameValidation(
      {required String name, required context, bool isFullNameField = false}) {
    if (!name.isNotEmpty) {
      return isFullNameField
          ? S.of(context).theFullNameFieldIsEmpty
          : S.of(context).theNickNameFieldIsEmpty;
    } else if (name.contains(RegExp(StringManager.nameExpression))) {
      return S.of(context).nameFieldShouldNotContainNumbers;
    } else
      return StringManager.trueWord;
  }

  bool validateProfile({required context}) {
    if (nameValidation(name: fullName.text, context: context,isFullNameField: true) ==
            StringManager.trueWord &&
        nameValidation(name: nickName.text, context: context) ==
            StringManager.trueWord && imageFile!=null) {
      return true;
    } else {
      return false;
    }
  }

  String getValidateError({required context}) {
    String fullNameError =
        nameValidation(name: fullName.text, context: context,isFullNameField: true);
    String nickNameError =
        nameValidation(name: nickName.text, context: context);
    if (fullNameError != StringManager.trueWord) {
      return fullNameError;
    } else if(nickNameError != StringManager.trueWord)
      return nickNameError;
    else
      return S.of(context).youShouldChooseProfilePhoto;

  }

  createProfileProcess({required context}) {
    if (validateProfile(context: context)) {
      createProfile();
    } else {
      getToastMessage(message: getValidateError(context: context));
    //  uploadImage();
    }
  }

  createProfile() async {
    uploadImage();
    emit(CreateProfileLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles);
    await data.add({
      StringManager.userEmail: email.text,
      StringManager.userFullName: fullName.text,
      StringManager.userNickName: nickName.text,
      StringManager.userPhone: phone.text,
      StringManager.userGender: gender.toString().substring(7),
      StringManager.userAge: age,
      StringManager.userHeight: height,
      StringManager.userWeight: weight,
      StringManager.userLevel: activityLevels[currentActivityLevel],
     StringManager.userImageLink:imageLink.toString(),
     StringManager.userIsPremium:false,
     StringManager.userIsClint:true

    }).then((value) {

      emit(CreateProfileSuccessState());
      getToastMessage(
        message: 'successfully Created',
      );
    }).catchError((error) {
      getToastMessage(
        message: 'an error has happened',
      );
      emit(CreateProfileErrorState());
      debugPrint(error.toString());
    });
  }
}
