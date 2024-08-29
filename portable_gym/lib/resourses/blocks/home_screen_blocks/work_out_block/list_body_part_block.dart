import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/work_out_models/body_category_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/level_screen.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/alert_box_manager.dart';
import '../../../models/profile_models/profile_model.dart';
import 'body_parts_item_block.dart';

class ListBodyPartBlock extends StatelessWidget {
  final List<BodyCategoryModel> bodyCategoryModel;
  final ProfileModel profileModel;
  final bool Function(BodyCategoryModel) isSelectedFunction;
  final Function(BodyCategoryModel) addToActivityOfDayList;
  final Function(BodyCategoryModel) deleteFromActivityOfDayList;
  const ListBodyPartBlock(
      {super.key, required this.bodyCategoryModel, required this.profileModel,
      required this.isSelectedFunction,
        required this.addToActivityOfDayList,
        required this.deleteFromActivityOfDayList
      });

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
    return BlocConsumer<ProgressTrackingCubit, ProgressTrackingState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var workCubit = WorkOutCubit.get(context);
        return Expanded(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s16),
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(LevelScreen(
                      bodyCategory: bodyCategoryModel[index].english!.title!,
                      title: bodyCategoryModel[index]
                          .getLanguageClass(context)
                          .title!,
                      workCubit: WorkOutCubit.get(context),
                    ));
                  },
                  onLongPress: () {
                    workCubit.clearBodyCategoryAttributes();
                    workCubit.setBodyCategoryAttributes(
                        model: bodyCategoryModel[index]);
                    showAlertBodyCategoryBox(
                      context: context,
                      workOutCubit: workCubit,
                      title: S.of(context).editBodyCategory,
                      buttonLable: S.of(context).uploadBodyCategory,
                      tabBar: bodyCategoryTabBar,
                      tabBarView: workCubit.getBodyCategoryTabBarView(
                          workOutCubit: workCubit),
                      buttonFunction: () {
                        workCubit.editBodyCategory(
                            docId: bodyCategoryModel[index].docId!);
                      },
                    );
                  },
                  child: BodyPartItemBlock(
                    bodyCategoryModel: bodyCategoryModel[index],
                    profileModel: profileModel,
                    deleteFunction: () {
                      workCubit.processOfDeletingBodyCategory(
                          docId: bodyCategoryModel[index].docId!,
                          bodyCategory:
                              bodyCategoryModel[index].english!.title!);
                    },
                    isSelected: isSelectedFunction(bodyCategoryModel[index]),
                    addToActivityOfDayList: (model){

                      addToActivityOfDayList(model);
                    },
                    deleteFromActivityOfDayList: (model){
                      deleteFromActivityOfDayList(model);
                    },
                  )),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppVerticalSize.s22,
                  ),
              itemCount: bodyCategoryModel.length),
        );
      },
    );
  },
);
  }
}
