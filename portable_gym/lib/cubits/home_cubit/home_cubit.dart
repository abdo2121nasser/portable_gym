import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/nutraition_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/progress_tracking_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/work_out_screen.dart';

import '../../generated/l10n.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> topMenuScreens = [
    WorkOutScreen(),
    NutritionScreen(),
    ProgressTrackingScreen(),
  ];
  getTopMenuImages({required int index}) {
    List<String> images = [
      ImageManager.kWeightImage,
      ImageManager.kNutraitionImage,
      ImageManager.kProgressTrackingImage,
      ImageManager.kWeightImage,
    ];
    return images[index];
  }

  getTopMenuLables({required context, required int index}) {
    List<String> lables = [
      S.of(context).workOut,
      S.of(context).nutraitions,
      S.of(context).progressTrack,
      S.of(context).weight,
    ];
    return lables[index];
  }

  navigateToTopMenuScreens({required int index}) {
    switch (index)
    {
      case 0:
        Get.to(WorkOutScreen());
        break;
      case 1:
        Get.to(NutritionScreen());
        break;
      case 2:
        Get.to(ProgressTrackingScreen());
        break;

      default:


    }
  }
}
