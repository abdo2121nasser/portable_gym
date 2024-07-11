import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../general_blocks/full_input_block.dart';




class ArabicFoodMainElementTabBarBlock extends StatelessWidget {
  const ArabicFoodMainElementTabBarBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {},
      builder: (context, state) {
        var nutCubit = NutritionCubit.get(context);
        return Column(
          children: [
            FullInputBlock(lable: 'العنوان', color: ColorManager.kBlackColor,
                enableBorder: true,
                isArabicTabView: true,
                controller: nutCubit.englishMainElementTitleController) ,
            FullInputBlock(lable: 'الوصف', color: ColorManager.kBlackColor,
                enableBorder: true,
                isArabicTabView: true,
                controller: nutCubit.englishMainElementDescriptionController) ,
          ],
        );
      },
    );
  }
}
