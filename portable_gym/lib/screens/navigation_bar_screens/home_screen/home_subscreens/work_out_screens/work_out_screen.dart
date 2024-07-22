import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/level_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/body_parts_item_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/element_category_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/floating_action_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/list_body_part_block.dart';
import '../../../../../resourses/blocks/general_blocks/daily_activity_block.dart';
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
    return BlocProvider.value(
      value: WorkOutCubit.get(context)
        ..getBodyCategories()
        ..getDailyBodyCategory(),
      child: BlocConsumer<WorkOutCubit, WorkOutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var workCubit = WorkOutCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.kBlackColor,
            appBar: AppBar(
              backgroundColor: ColorManager.kBlackColor,
              leadingWidth: AppHorizontalSize.s150,
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
                        S.of(context).workOut,
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
                HorizontalCategoryListBlock(
                  currentLevel: workCubit.currentLevel,
                  numberOfLevels: 3,
                  lables: workCubit.getLevelLabels(context: context),
                  changeLevel: (index) {
                    workCubit.changeCurrentLevel(newLevel: index);
                  },
                ),
                workCubit.dailyDodyCategoryModel == null
                    ? Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ColorManager.kBlue,
                            )),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppVerticalSize.s20),
                        child: InkWell(
                          onTap: () {
                            Get.to(LevelScreen(
                              bodyCategory: '',
                              isDailyCategory: true,
                            ));
                          },
                          onLongPress: () {
                            workCubit.clearBodyCategoryAttributes();
                            workCubit.setBodyCategoryAttributes(
                                model: workCubit.dailyDodyCategoryModel!);
                            showAlertBodyCategoryBox(
                              context: context,
                              title: S.of(context).editBodyCategory,
                              buttonLable: S.of(context).uploadBodyCategory,
                              tabBar: bodyCategoryTabBar,
                              tabBarView: workCubit.BodyCategoryTabBarView,
                              buttonFunction: () {
                                workCubit.editBodyCategory(
                                    docId: workCubit
                                        .dailyDodyCategoryModel!.docId!,
                                    isDailyCategory: true);
                              },
                            );
                          },
                          child: DailyActivityBlock(
                            bodyCategoryModel:
                                workCubit.dailyDodyCategoryModel!,
                            title: S.of(context).trainingOfDay,
                          ),
                        ),
                      ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppHorizontalSize.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).letsGo +
                            '${workCubit.getBodyCategoryLevelString(currentLevelIndex: workCubit.currentLevel, isLable: true, context: context)}',
                        textAlign: TextAlign.start,
                        style: getMediumStyle(
                            fontSize: FontSize.s20,
                            color: ColorManager.kLimeGreenColor,
                            fontFamily: FontFamily.kPoppinsFont),
                      ),
                      Text(
                        S.of(context).exploreDifferentWorkoutStyles,
                        textAlign: TextAlign.start,
                        style: getRegularStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.kWhiteColor,
                            fontFamily: FontFamily.kPoppinsFont),
                      ),
                    ],
                  ),
                ),
                state is GetBodyCategoryLoadingState
                    ? Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ColorManager.kBlue,
                            )),
                      )
                    : ListBodyPartBlock(
                        bodyCategoryModel: workCubit.bodyCategoryModel,
                      ),
              ],
            ),
            floatingActionButton: FloatingActionButtonBlock(
              function: () {
                workCubit.clearBodyCategoryAttributes();

                showAlertBodyCategoryBox(
                    context: context,
                    title: S.of(context).addBodyCategory,
                    buttonLable: S.of(context).uploadBodyCategory,
                    tabBar: bodyCategoryTabBar,
                    tabBarView: workCubit.BodyCategoryTabBarView,
                    buttonFunction: workCubit.processOfAddingBodyCategory);
              },
            ),
          );
        },
      ),
    );
  }
}
