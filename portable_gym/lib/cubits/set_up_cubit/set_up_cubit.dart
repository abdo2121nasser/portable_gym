import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/set_up_bodies_blocks/activity_level_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/age_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/fill_profile_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/gender_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/goal_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/height_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/weight_set_up_block.dart';
import '../../resourses/managers_files/enum_manager.dart';

part 'set_up_state.dart';

class SetUpCubit extends Cubit<SetUpState> {
  SetUpCubit() : super(SetUpInitial());

  static SetUpCubit get(context) => BlocProvider.of(context);
  int currentPageBodyIndex = 0;

  // TextEditingController loginEmail = TextEditingController();
  // TextEditingController loginPassword = TextEditingController();
  // TextEditingController registerEmail = TextEditingController();
  // TextEditingController registerName = TextEditingController();
  // TextEditingController registerPassword = TextEditingController();
  // TextEditingController registerConfirmPassword = TextEditingController();
  // TextEditingController forgetPasswordEmail = TextEditingController();
  //----------------------------------------------------------
  RulerPickerController WeightController = RulerPickerController(value: 60);
  WeightSliderController heightController = WeightSliderController(
      initialWeight: 160, minWeight: 0, interval: 1, maxWeight: 220);

  int age = 30;
  int weight = 60;
  int height = 160;
  Gender gender = Gender.male;
  TextEditingController nickName=TextEditingController();
  TextEditingController phone=TextEditingController();
  //-------------------------------------------------
  //----------------------------------------------
  var pickedFilename;
  File? imageFile;
  var imagePicker=ImagePicker();
  //------------------------------------------
 List<Widget>  getPageBody({required SetUpCubit setUpCubit}){
    return  [
  GenderSetUpBlock(),
  AgeSetUpBlock(),
  WeightSetUpBlock(),
  HeightSetUpBlock(),
  GoalSetUpBlock(),
  ActivityLevelSetUpBlock(),
  FillProfileSetUpBlock(setCubit: setUpCubit,)
  ];
  }
  incrementPageBodyIndex() {
    currentPageBodyIndex++;
    emit(IncrementPageBodyIndexState());
  }

  decrementPageBodyIndex() {
    if(currentPageBodyIndex==0) return;
    currentPageBodyIndex--;
    emit(DecrementPageBodyIndexState());
  }

  setUpForwardNavigation({required context}) {
    if (currentPageBodyIndex == 6) {

    } else {
      incrementPageBodyIndex();
    }
  }

  setUpBackWardNavigation({required context}) {
    if (currentPageBodyIndex == 0) {
      Navigator.pop(context);
    } else {
      decrementPageBodyIndex();
    }
  }

  String getTitle({required context}) {
    String title = '';
    switch (currentPageBodyIndex) {
      case 0:
        title = S.of(context).whatsYourGender;
        break;
      case 1:
        title = S.of(context).howOldAreYou;
        break;
      case 2:
        title = S.of(context).whatsYourWeight;
        break;
      case 3:
        title = S.of(context).whatsYourHeight;
        break;
      case 4:
        title = S.of(context).whatsYourGoal;
        break;
      case 5:
        title = S.of(context).physicalActivityLevel;
        break;
      case 6:
        title = S.of(context).fillYourProfile;
        break;
    }
    return title;
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

  getFillProfileInputsLables({required context,required int index}) {
    List<String> lables = [
      S.of(context).fullName,
      S.of(context).nickName,
      S.of(context).email,
      S.of(context).phone,
    ];
    return lables[index];
  }
  getFillProfileInputControllers({required context,required int index}) {

    List<TextEditingController> inputControllers = [
      AuthenticationCubit.get(context).registerName,
      nickName,
      AuthenticationCubit.get(context).registerEmail,
      phone
    ];
    return inputControllers[index];
  }


  Future<void> pickImage()
  async {
    emit(PickImageLoadingState());
    final pickedFile=await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null)
    {
      pickedFilename=pickedFile.path.split('/').last;
      imageFile=File(pickedFile.path);
     emit(PickImageSuccessState());
    }
    else
    {
      print('no image selected');
      emit(PickImageErrorState());
    }

  }
}
