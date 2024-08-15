import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/floating_action_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/list_training_items_block.dart';
import '../../../../../resourses/managers_files/alert_box_manager.dart';
import '../../../../../resourses/managers_files/color_manager.dart';

class LevelScreen extends StatelessWidget {
  final String bodyCategory;
  final bool isDailyCategory;
  final WorkOutCubit workCubit;
  final String  title;

  const LevelScreen(
      {super.key, required this.bodyCategory,
      required this.workCubit,
        required this.title,
      this.isDailyCategory = false});

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
    return BlocProvider(
  create: (context) => FavouriteCubit()..getUserDocId(),
  child: BlocProvider.value(
      value: workCubit
        ..getTraining(
            bodyCategory: bodyCategory, isDailyCategory: isDailyCategory),
      child: BlocConsumer<WorkOutCubit, WorkOutState>(
        listener: (context, state) {},
        builder: (context, state) {
          // var workCubit=WorkOutCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: GeneralAppBarBlock(
              title: title,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //   TrainingOfDayBlock(trainingName: 'functional trainnning'),
                state is GetTrainingLoadingState ||
                state is GetUserDocIdLoadingState
                    ? const Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ColorManager.kPurpleColor,
                            )),
                      )
                    : ListTrainingItemsBlock(
                        trainingModels: workCubit.trainingModels,
                        bodyCategory: bodyCategory,
                  isDailyCategory: isDailyCategory,
                      ),
              ],
            ),
            floatingActionButton: FloatingActionButtonBlock(
              function: () {
                showAlertTrainingBox(
                    context: context,
                    workOutCubit: workCubit,
                    title: S.of(context).addNewTraining,
                    buttonLable: S.of(context).uploadTraining,
                    tabBar: trainingTabBar,
                    tabBarView: workCubit.getTrainingTabBarView(
                        workOutCubit: workCubit),
                    trainingPeriod: workCubit.trainingPeriod,
                    buttonFunction: () {
                      workCubit.processOfAddingTraining(
                          bodyCategory: bodyCategory,
                          isDailyCategory: isDailyCategory
                      );
                    });
                workCubit.clearTrainingAttributes();
                // await pickImage();
                //await google.uploadFileToGoogleDrive(imageFile!);
              },
            ),
          );
        },
      ),
    ),
);
  }
}
