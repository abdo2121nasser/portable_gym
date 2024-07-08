import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';

import '../../../../generated/l10n.dart';
import '../../../../resourses/managers_files/color_manager.dart';
import '../../../../resourses/managers_files/font_manager.dart';
import '../../../../resourses/managers_files/style_manager.dart';

class NutritionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionCubit, NutritionState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var nutCubit=NutritionCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        backgroundColor: ColorManager.kBlackColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.4,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_left,
                color: ColorManager.kLimeGreenColor,
              ),
              Expanded(
                child: Text(
                  S.of(context).nutraitions,
                  style: getBoldStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.kPurpleColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          HorizontalCategoryListBlock(
              currentLevel: nutCubit.currentPlane,
              numberOfLevels: 2,
              lables: nutCubit.getMealPlaneLabel(context: context),
              changeLevel: (index){
                nutCubit.changeCurrentPlane(index: index);
              }),

        ],
      ),
    );
  },
);
  }
}
