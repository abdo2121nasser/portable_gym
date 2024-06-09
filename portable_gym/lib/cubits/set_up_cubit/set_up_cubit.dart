import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/set_up_bodies_blocks/activity_level_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/age_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/fill_profile_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/gender_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/goal_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/height_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/weight_set_up_block.dart';

part 'set_up_state.dart';

class SetUpCubit extends Cubit<SetUpState> {
  SetUpCubit() : super(SetUpInitial());
  static SetUpCubit get(context) => BlocProvider.of(context);
  List<Widget> pageBody = [
    GenderSetUpBlock(),
    AgeSetUpBlock(),
    WeightSetUpBlock(),
    HeightSetUpBlock(),
    GoalSetUpBlock(),
    ActivityLevelSetUpBlock(),
    FillProfileSetUpBlock()
  ];
  int currentPageBodyIndex = 0;
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

}
