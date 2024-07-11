import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/full_input_block.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../managers_files/color_manager.dart';



class EnglishFoodMainElementTabBarBlock extends StatelessWidget {
  const EnglishFoodMainElementTabBarBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {},
      builder: (context, state) {
        var nutCubit = NutritionCubit.get(context);
        return Column(
          children: [
          FullInputBlock(lable: 'title', color: ColorManager.kBlackColor,
               enableBorder: true,
               controller: nutCubit.englishMainElementTitleController) ,
            FullInputBlock(lable: 'description', color: ColorManager.kBlackColor,
               enableBorder: true,
               controller: nutCubit.englishMainElementDescriptionController) ,
          ],
        );
      },
    );
  }
}
