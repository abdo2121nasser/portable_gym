import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/answers_of_questions_screen.dart';

import '../../../../general_blocks/option_list_block.dart';


class AdminViewBlock extends StatelessWidget {
  const AdminViewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    var nutCubit=NutritionCubit.get(context);
    return BlocProvider.value(
      value: nutCubit..getAllMealPlanRequests(),
      child: BlocConsumer<NutritionCubit, NutritionState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Expanded(
        child: state is GetAllMealPlanRequestsLoadingState?
      const Center(child: CircularProgressIndicator(color: ColorManager.kPurpleColor,)):
        Column(
          children: [
            SizedBox(height: AppVerticalSize.s10,),
            OptionsListBlock(
              icons: List<IconData>.generate(nutCubit.requestsModels.length, (index) => Icons.person,growable: true),
              lables: List<String>.generate(nutCubit.requestsModels.length, (index) => nutCubit.requestsModels[index].userNickName,growable: true),
              onClickFunction: (index, context) {
                       Get.to(AnswersOfQuestionsScreen(model: nutCubit.requestsModels[index].questions,));
              },
            ),
          ],
        ),
      );
  },
),
    );
  }
}
