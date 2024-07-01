import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/training_of_day_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/floating_action_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/round_item_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/rounds_block.dart';
import '../../../../../resourses/managers_files/alert_box_manager.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import 'exercise_screen.dart';

class LevelScreen extends StatelessWidget {
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
  listener: (context, state) {
  },
  builder: (context, state) {
    var workCubit=WorkOutCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kBlackColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.35,
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
                  S.of(context).beginner,
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
          TrainingOfDayBlock(trainingName: 'functional trainnning'),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20, vertical: AppVerticalSize.s10),
                itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      Get.to(ExerciseScreen());
                    },
                    child: RoundItemBlock()),
                separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s5,),
                itemCount: 2),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonBlock(function: ()  {
        showAlertTrainingBox(
            context: context,
            tabBar: trainingTabBar,
            tabBarView: workCubit.TrainingTabBarView,
            trainingPeriod: workCubit.trainingPeriod,
            processOfAddingTraining: workCubit.processOfAddingTraining
        );
        // await pickImage();
        //await google.uploadFileToGoogleDrive(imageFile!);
      },),

    );
  },
);
  }
}
