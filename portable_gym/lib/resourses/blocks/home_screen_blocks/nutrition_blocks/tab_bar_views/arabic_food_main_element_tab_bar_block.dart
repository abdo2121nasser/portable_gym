import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/string_manager.dart';
import '../../../general_blocks/full_input_block.dart';


class ArabicFoodMainElementTabBarBlock extends StatelessWidget {
  NutritionCubit nutCubit;

  ArabicFoodMainElementTabBarBlock({required this.nutCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
       value: nutCubit,
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {},
        builder: (context, state) {
          //   var nutCubit = NutritionCubit.get(context);
          return Column(
            children: [
              FullInputBlock(lable: StringManager.arabicFoodMainElementTitle,
                  color: ColorManager.kBlackColor,
                  enableBorder: true,
                  isArabicTabView: true,
                  controller: nutCubit.arabicMainElementTitleController),
              FullInputBlock(
                  lable: StringManager.arabicFoodMainElementDescription,
                  color: ColorManager.kBlackColor,
                  enableBorder: true,
                  isArabicTabView: true,
                  multiLine: true,
                  controller: nutCubit.arabicMainElementDescriptionController),
            ],
          );
        },
      ),
    );
  }
}
