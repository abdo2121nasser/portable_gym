import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../managers_files/color_manager.dart';


class EnglishFoodMainElementTabBarBlock extends StatelessWidget {
  NutritionCubit nutCubit;


  EnglishFoodMainElementTabBarBlock({required this.nutCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
value: nutCubit,
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {},
        builder: (context, state) {
          //var nutCubit = NutritionCubit.get(context);
          return Column(
            children: [
              FullInputBlock(lable: StringManager.englishFoodMainElementTitle,
                  color: ColorManager.kBlackColor,
                  enableBorder: true,
                  controller: nutCubit.englishMainElementTitleController),
              FullInputBlock(
                  lable: StringManager.englishFoodMainElementDescription,
                  color: ColorManager.kBlackColor,
                  enableBorder: true,
                  multiLine: true,
                  controller: nutCubit.englishMainElementDescriptionController),
            ],
          );
        },
      ),
    );
  }
}
