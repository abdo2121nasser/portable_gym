import 'package:flutter/material.dart';
import 'package:my_coach/resourses/blocks/general_blocks/recorded_unit_block.dart';
import 'package:my_coach/resourses/models/nutrition_models/recipe_model.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/values_manager.dart';

class GridRecipeMeasurementsBlock extends StatelessWidget {
  final LanguageClassRecipeModel languageModel;


  GridRecipeMeasurementsBlock({required this.languageModel});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons=[
      Icons.local_fire_department_outlined,
      Icons.accessibility_new_rounded,
      Icons.fiber_manual_record_sharp,

    ];
    List<String> lables=[
      S.of(context).kCalPerGram,
      S.of(context).protein,
      S.of(context).carbohydrate,

    ];
    List<String> values=[
    languageModel.calories!,
    languageModel.protein!,
    languageModel.carbohydrates!,
    ];
    return SizedBox(
      height: AppVerticalSize.s120,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisExtent: 140,
            crossAxisSpacing: 0,
            childAspectRatio: (3.3 / 0.3),
            mainAxisSpacing: 15),
        itemBuilder: (context, index) => RecordedUnitBlock(
            icon: icons[index], mesuaringUnit: lables[index], unitValue: values[index]),
        itemCount: values.length,
      ),
    );
  }
}
