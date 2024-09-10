import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/level_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';
import '../../../../../resourses/blocks/general_blocks/floating_action_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/list_body_part_block.dart';
import '../../../../../resourses/blocks/general_blocks/daily_activity_block.dart';
import '../../../../../resourses/managers_files/alert_box_manager.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';

class WorkOutScreen extends StatelessWidget {
  final ProfileModel profileModel;
  const WorkOutScreen({super.key, required this.profileModel});

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
    return BlocProvider(
      create: (context) => ProgressTrackingCubit(userDocId: profileModel.docId),
      child: BlocProvider(
        create: (context) => WorkOutCubit()
          ..getBodyCategories()
          ..getDailyBodyCategoryCard(
              hasAccess:
                  (profileModel.isPremium || profileModel.isClient == false)),
        child: BlocConsumer<WorkOutCubit, WorkOutState>(
          listener: (context, state) {},
          builder: (context, state) {
            var workCubit = WorkOutCubit.get(context);
            var progCubit = ProgressTrackingCubit.get(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorManager.kBlackColor,
              appBar: GeneralAppBarBlock(
                title: S.of(context).workOut,
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
                  (profileModel.isPremium || profileModel.isClient == false)
                      ? workCubit.dailyDodyCategoryModel == null
                          ? Expanded(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: ColorManager.kBlue,
                                  )),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppVerticalSize.s20),
                              child: InkWell(
                                onTap: () {
                                  Get.to(LevelScreen(
                                    profileModel: profileModel,
                                    bodyCategory: '',
                                    title: workCubit.dailyDodyCategoryModel!
                                        .getLanguageClass(context)
                                        .title!,
                                    downloadLink: workCubit
                                        .dailyDodyCategoryModel!
                                        .downloadFileLink,
                                    isDailyCategory: true,
                                    workCubit: workCubit,
                                  ));
                                },
                                onLongPress:
                                    (profileModel.isClient == false)
                                        ? () {
                                            workCubit
                                                .clearBodyCategoryAttributes();
                                            workCubit.setBodyCategoryAttributes(
                                                model: workCubit
                                                    .dailyDodyCategoryModel!);
                                            showAlertBodyCategoryBox(
                                              context: context,
                                              workOutCubit: workCubit,
                                              title: S
                                                  .of(context)
                                                  .editBodyCategory,
                                              buttonLable: S
                                                  .of(context)
                                                  .uploadBodyCategory,
                                              tabBar: bodyCategoryTabBar,
                                              tabBarView: workCubit
                                                  .getBodyCategoryTabBarView(
                                                workOutCubit: workCubit,
                                                isDailyBodyCategory: true,
                                              ),
                                              buttonFunction: () {
                                                workCubit.editBodyCategory(
                                                    docId: workCubit
                                                        .dailyDodyCategoryModel!
                                                        .docId!,
                                                    isDailyCategory: true);
                                              },
                                            );
                                          }
                                        : null,
                                child: DailyActivityBlock(
                                  bodyCategoryModel:
                                      workCubit.dailyDodyCategoryModel!,
                                  title: S.of(context).trainingOfDay,
                                ),
                              ),
                            )
                      : SizedBox(height: AppVerticalSize.s14),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppHorizontalSize.s16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).letsGo}${workCubit.getBodyCategoryLevelString(currentLevelIndex: workCubit.currentLevel, isLable: true, context: context)}',
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
                      ? const Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: ColorManager.kPurpleColor,
                              )),
                        )
                      : ListBodyPartBlock(
                          bodyCategoryModel: workCubit
                              .bodyCategoryModels[workCubit.currentLevel],
                          profileModel: profileModel,
                          isSelectedFunction: (model) {
                            return progCubit.isActivityOfDay(model: model);
                          },
                          addToActivityOfDayList: (model) {
                            progCubit.addActivityOfDay(model: model);
                          },
                          deleteFromActivityOfDayList: (model) {
                            progCubit.deleteActivityOfDay(model: model);
                          },
                        ),
                ],
              ),
              floatingActionButton: (profileModel.isClient == false)
                  ? FloatingActionButtonBlock(
                      function: () {
                        workCubit.clearBodyCategoryAttributes();

                        showAlertBodyCategoryBox(
                            context: context,
                            workOutCubit: workCubit,
                            title: S.of(context).addBodyCategory,
                            buttonLable: S.of(context).uploadBodyCategory,
                            tabBar: bodyCategoryTabBar,
                            tabBarView: workCubit.getBodyCategoryTabBarView(
                                workOutCubit: workCubit),
                            buttonFunction:
                                workCubit.processOfAddingBodyCategory);
                      },
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
