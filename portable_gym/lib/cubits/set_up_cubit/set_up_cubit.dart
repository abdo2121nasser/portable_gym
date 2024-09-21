import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/answer_questions_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/main_navigation_bar_screen.dart';
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
  SetUpCubit({required String email,required this.isAdmin}) : super(SetUpInitial()) {
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
  int currentGoal = 0;

  TextEditingController nickName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool isAdmin;
  //-------------------------------------------------
  //----------------------------------------------
  var pickedFilename;
  File? imageFile;
  String imageLink = '';
  //------------------------------------------
  List<Widget> getPageBody({required SetUpCubit setUpCubit}) {
    return [
      const GenderSetUpBlock(),
      AgeSetUpBlock(),
      WeightSetUpBlock(),
      HeightSetUpBlock(),
      // GoalSetUpBlock(),
      //  ActivityLevelSetUpBlock(),
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
    if (currentPageBodyIndex == 4) {
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
    List<String> lables = [
      S.of(context).whatsYourGender,
      S.of(context).howOldAreYou,
      S.of(context).whatsYourWeight,
      S.of(context).whatsYourHeight,
      //S.of(context).whatsYourGoal,
      //S.of(context).physicalActivityLevel,
      S.of(context).fillYourProfile,
    ];

    return lables[currentPageBodyIndex];
  }

  String getButtonText({required context}) {
    if (currentPageBodyIndex != 4) {
      return S.of(context).continued;
    } else {
      return S.of(context).start;
    }
  }

  Color getButtonColor({required context}) {
    if (currentPageBodyIndex != 4) {
      return ColorManager.kBlackColor;
    } else {
      return ColorManager.kLimeGreenColor;
    }
  }

  Color getTextColor({required context}) {
    if (currentPageBodyIndex != 4) {
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

  List<String> getGoals({context, bool isStringManager = false}) {
    if (isStringManager) {
      return [
        StringManager.userWeightLoss,
        StringManager.userWeightGain,
        StringManager.userMusclesMassGain,
        StringManager.userShapeBody,
        StringManager.userOther,
      ];
    } else {
      return [
        S.of(context).weightLoss,
        S.of(context).weightGain,
        S.of(context).musclesMassGain,
        S.of(context).shapeBody,
        S.of(context).other,
      ];
    }
  }

  changeCurrentActivityLevel({required int index}) {
    currentActivityLevel = index;
    emit(ChangeActivityLevelState());
  }

  changeCurrentGoal({required int index}) {
    currentGoal = index;
    emit(ChangeGoalState());
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
      emit(PickImageErrorState());
      debugPrint('no image selected');
    }
  }

  uploadImage() async {
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
    if (nameValidation(
                name: fullName.text, context: context, isFullNameField: true) ==
            StringManager.trueWord &&
        nameValidation(name: nickName.text, context: context) ==
            StringManager.trueWord &&
        imageFile != null) {
      return true;
    } else {
      return false;
    }
  }

  String getValidateError({required context}) {
    String fullNameError = nameValidation(
        name: fullName.text, context: context, isFullNameField: true);
    String nickNameError =
        nameValidation(name: nickName.text, context: context);
    if (fullNameError != StringManager.trueWord) {
      return fullNameError;
    } else if (nickNameError != StringManager.trueWord)
      return nickNameError;
    else
      return S.of(context).youShouldChooseProfilePhoto;
  }

  createProfileProcess({required context}) {
    if (validateProfile(context: context)) {
      Get.to(AnswerQuestionsScreen(
          userNickName: nickName.text,
          collection: StringManager.collectionQuestionsOfProfile,
          finishProfileSetupFunction: ( Map<String,dynamic> questionsMap)  async {
          await  createProfile(questionsMap: questionsMap);
          }));
    } else {
      getToastMessage(message: getValidateError(context: context));
    }
  }

 Future<void> createProfile({required Map<String,dynamic> questionsMap}) async {
    await uploadImage();
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
      // StringManager.userLevel: activityLevels[currentActivityLevel],
      // StringManager.userGoal: getGoals(isStringManager: true)[currentGoal],
      StringManager.userImageLink: imageLink.toString(),
      StringManager.userIsPremium: false,
      StringManager.userIsClint: !isAdmin,
      StringManager.profileQuestionsAnswer: questionsMap,

    }).then((value) {
      emit(CreateProfileSuccessState());
      getToastMessage(
        message: 'successfully Created',
      );
      saveUserDocId(userDocId: value.id);
      Get.offAll(const MainNavigationBarScreen());
    }).catchError((error) {
      getToastMessage(
        message: 'an error has happened',
      );
      emit(CreateProfileErrorState());
      debugPrint(error.toString());
    });
  }

  saveUserDocId({required String userDocId}) async {
    emit(SaveUserDataDocIdLoadingState());
    await const FlutterSecureStorage()
        .write(key: StringManager.userDocId, value: userDocId)
        .then((value) {
      emit(SaveUserDataDocIdSuccessState());
    }).catchError((error) {
      emit(SaveUserDataDocIdErrorState());
      debugPrint(error);
    });
  }
}
