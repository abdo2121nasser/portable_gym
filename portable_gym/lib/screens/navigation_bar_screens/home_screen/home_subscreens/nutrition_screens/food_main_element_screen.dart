import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/floating_action_button_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/food_main_element_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';



class FoodMainElementScreen extends StatelessWidget {
  const FoodMainElementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TabBar foodMainElementTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return BlocConsumer<NutritionCubit, NutritionState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var nutCubit=NutritionCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kBlackColor,
        leadingWidth: AppHorizontalSize.s250,
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
                  S.of(context).foodMainElement,
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
      body:Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: AppHorizontalSize.s22,
                  vertical: AppVerticalSize.s14),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisExtent: 140,
                  crossAxisSpacing: AppHorizontalSize.s22,
                  childAspectRatio: (1.5 / 0.9),
                  mainAxisSpacing: AppVerticalSize.s14),
              itemBuilder: (context, index) => FoodMainElementBlock(title: 'dfd',content: 'dfdfdf',),
              itemCount: 3,
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButtonBlock(function: (){
        showAlertFoodMainElementBox(context: context,
            tabBar: foodMainElementTabBar,
            tabBarView: nutCubit.foodMainElementTabBarViews,
            buttonFunction: (){},
            title: S.of(context).foodMainElement,
            buttonLable: S.of(context).add);
      },),


    );
  },
);
  }
}
