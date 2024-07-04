import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/round_item_block.dart';

import '../../../../generated/l10n.dart';
import '../../../../screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';
import '../../../managers_files/alert_box_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/work_out_models/training_model.dart';

class TrainingItemsBlock extends StatelessWidget {
  final List<TrainingModel> trainingModel;
  final String bodyCategory;

  TrainingItemsBlock({required this.trainingModel, required this.bodyCategory});

  @override
  Widget build(BuildContext context) {
    final TabBar trainingTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var workCubit = WorkOutCubit.get(context);
        return Expanded(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(
                  horizontal: AppHorizontalSize.s20,
                  vertical: AppVerticalSize.s10),
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(ExerciseScreen(
                      trainingModel: trainingModel[index],
                    ));
                  },
                  onLongPress: () {
                    workCubit.clearTrainingAttributes();

                    workCubit.setTrainingAttributes(
                        model: trainingModel[index]);

                    showAlertTrainingBox(
                        context: context,
                        title: S.of(context).editTraining,
                        buttonLable: S.of(context).uploadTraining,
                        tabBar: trainingTabBar,
                        tabBarView: workCubit.TrainingTabBarView,
                        trainingPeriod: workCubit.trainingPeriod,
                        buttonFunction: () {
                          workCubit.editTraining(
                              docId: trainingModel[index].docId!,
                              bodyCategory: bodyCategory);
                        });
                  },
                  child: RoundItemBlock(
                    trainingModel: trainingModel[index],
                    deleteFunction: () {
                      workCubit.deleteTraining(
                          docId: trainingModel[index].docId!,
                          bodyCategory: bodyCategory);
                    },
                  )),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppVerticalSize.s5,
                  ),
              itemCount: trainingModel.length),
        );
      },
    );
  }
}
