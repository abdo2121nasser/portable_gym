import 'package:flutter/material.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';

import '../../../managers_files/values_manager.dart';
import '../../general_blocks/square_element _block.dart';



class SelectSquareGridViewBlock extends StatelessWidget {
  const SelectSquareGridViewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    var nutCubit=NutritionCubit.get(context);
    return Expanded(child:
    GridView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s22,
          vertical: AppVerticalSize.s14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: (1 / .8),
          mainAxisSpacing: 15),
      itemBuilder: (context, index) {
        var model=nutCubit.recipeModels[index].getLanguageClass(context);
        return InkWell(
          onTap: () {

          },
          child: SquareElementBlock(
            title: model.name!,
            subValue:model.calories!,
            imageLink: nutCubit.recipeModels[index].imageLink,
            canBeDeleted: true,
            hasFavouriteIcon: false,
            hasSelectIcon: true,
            isSelected: true,
          ));
      },
      itemCount: nutCubit.recipeModels.length,
    )
    );
  }
}
