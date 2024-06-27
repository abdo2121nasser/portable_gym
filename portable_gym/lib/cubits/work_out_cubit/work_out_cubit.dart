import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/english_tab_bar_view_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/arabic_tab_bar_view_block.dart';

part 'work_out_state.dart';

class WorkOutCubit extends Cubit<WorkOutState> {
  WorkOutCubit() : super(WorkOutInitial());
  static WorkOutCubit get(context) => BlocProvider.of(context);
  GoogleDriveSevice? googleDriveSevice;
  TabBar trainingTabBar = const TabBar(
    tabs: [Tab(text: 'english'), Tab(text: 'arabic')],
    indicatorColor: Colors.blue,
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
  );
  TabBarView tabBarView = TabBarView(children: [
    EnglishTabBarViewBlock(),
      ArabicTabBarViewBlock()
  ]);
  List<String> trainingEnglishLables = [
    StringManager.trainingEnglishLableName,
    StringManager.trainingEnglishLableLevel,
    StringManager.trainingEnglishLablePeriod,
    StringManager.trainingEnglishLableNumberOfRepetation,
    StringManager.trainingEnglishInstruction
  ];
  List<String> trainingArabicLables = [
    StringManager.trainingArabicLableName,
    StringManager.trainingArabicLableLevel,
    StringManager.trainingArabicLablePeriod,
    StringManager.trainingArabicLableNumberOfRepetation,
    StringManager.trainingArabicInstruction
  ];
  TextEditingController trainingEnglishNameController              =TextEditingController();
  TextEditingController trainingEnglishLevelController             =TextEditingController();
  TextEditingController trainingEnglishPeriodController             =TextEditingController();
  TextEditingController trainingEnglishNumberOfRepetationController=TextEditingController();
  TextEditingController trainingEnglishInstructionController=TextEditingController();

  TextEditingController trainingArabicNameController              =TextEditingController();
  TextEditingController trainingArabicLevelController             =TextEditingController();
  TextEditingController trainingArabicPeriodController             =TextEditingController();
  TextEditingController trainingArabicNumberOfRepetationController=TextEditingController();
  TextEditingController trainingArabicInstructionController=TextEditingController();

  getCategoryLabels({required int index, required context}) {
    List<String> lables = [
      S.of(context).beginner,
      S.of(context).intermediate,
      S.of(context).advanced,
    ];
    return lables[index];
  }
  List<TextEditingController> getTrainingEnglishControllers() {
    List<TextEditingController> controllers = [
      trainingEnglishNameController,
      trainingEnglishLevelController,
      trainingEnglishPeriodController,
      trainingEnglishNumberOfRepetationController,
      trainingEnglishInstructionController
    ];
    return controllers;
  }
  List<TextEditingController> getTrainingArabicControllers() {
    List<TextEditingController> controllers = [
      trainingEnglishNameController,
      trainingEnglishLevelController,
      trainingEnglishPeriodController,
      trainingEnglishNumberOfRepetationController,
      trainingEnglishInstructionController
    ];
    return controllers;
  }

  uploadFileToDrive({required File file}) {
    googleDriveSevice!.uploadFileToGoogleDrive(file);
    emit(UploadFileToDriveState());
  }
}
