import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/body_parts_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/category_element_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/category_list_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/floating_action_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/list_body_part_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/training_of_day_block.dart';
import '../../../../../resourses/managers_files/alert_box_manager.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';


class WorkOutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TabBar bodyCategoryTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var workCubit=WorkOutCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.kBlackColor,
          appBar: AppBar(
            backgroundColor: ColorManager.kBlackColor,
            leadingWidth: MediaQuery
                .of(context)
                .size
                .width * 0.3,
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
                      S
                          .of(context)
                          .workOut,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryListBlock(),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: AppVerticalSize.s20),
                child: TrainingOfDayBlock(trainingName:  'functional trainnig',),
              ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's go begginer",
                    textAlign: TextAlign.start,
                    style: getMeduimStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager
                            .kLimeGreenColor,
                        fontFamily:
                        FontFamily.kPoppinsFont),
                  ),
                  Text(
                    "Explore Different Workout Styles",
                    textAlign: TextAlign.start,
                    style: getRegularStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager
                            .kWhiteColor,
                        fontFamily:
                        FontFamily.kPoppinsFont),
                  ),
                ],
              ),
            ),
              ListBodyPartBlock(),

            ],
          ),
          floatingActionButton: FloatingActionButtonBlock(function: (){
            showAlertBodyCategoryBox(context: context,tabBar: bodyCategoryTabBar,tabBarView: workCubit.BodyCategoryTabBarView);
          },),
        );
      },
    );
  }
}
