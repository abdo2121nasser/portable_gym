import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/body_parts__itemblock.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/level_element_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/level_list_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/floating_action_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/list_body_part_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/training_of_day_block.dart';
import '../../../../../resourses/managers_files/alert_box_manager.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';

class WorkOutScreen extends StatefulWidget {
  @override
  State<WorkOutScreen> createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen> {
  bool isLoadingBodyCategory=false;

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
      value: WorkOutCubit.get(context)..getBodyCategories(),
  child: BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var workCubit = WorkOutCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.kBlackColor,
          appBar: AppBar(
            backgroundColor: ColorManager.kBlackColor,
            leadingWidth: MediaQuery.of(context).size.width * 0.3,
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
              LevelListBlock(),

              Padding(
                padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s20),
                child: InkWell(
                  onTap: (){},
                  onLongPress: (){},
                  child: TrainingOfDayBlock(
                    trainingName: 'functional training',
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
                      S.of(context).letsGo+'${workCubit.getBodyCategoryLevelString(currentLevelIndex: workCubit.currentLevel,isLable: true,context: context)}',
                      textAlign: TextAlign.start,
                      style: getMeduimStyle(
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
              state is GetBodyCategoryLoadingState?
              Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color:ColorManager.kBlue,)),
              ):
              ListBodyPartBlock(bodyCategoryModel: workCubit.bodyCategoryModel,),
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
              buttonFunction: workCubit.processOfAddingBodyCategory
              );
            },
          ),
        );
      },
    ),
);
  }
}
