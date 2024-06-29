import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/english_tab_bar_view_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/arabic_tab_bar_view_block.dart';
import '../../resourses/managers_files/toast_messege_manager.dart';

part 'work_out_state.dart';

class WorkOutCubit extends Cubit<WorkOutState> {
  WorkOutCubit() : super(WorkOutInitial());
  static WorkOutCubit get(context) => BlocProvider.of(context);
  GoogleDriveSevice googleDriveSevice = GoogleDriveSevice();
  DateTime trainingPeriod = DateTime(0, 0, 0, 0, 0, 0);
  //--------------------------------------------------------------------------------------
  TabBarView tabBarView =
      TabBarView(children: [EnglishTabBarViewBlock(), ArabicTabBarViewBlock()]);
  List<String> trainingEnglishLables = [
    StringManager.trainingEnglishLableName,
    StringManager.trainingEnglishLableLevel,
    StringManager.trainingEnglishLableNumberOfRepetation,
    StringManager.trainingEnglishLableRoundNumber,
    StringManager.trainingEnglishLableInstruction,
    StringManager.trainingEnglishLableVideoLink,
  ];
  List<String> trainingArabicLables = [
    StringManager.trainingArabicLableName,
    StringManager.trainingArabicLableLevel,
    StringManager.trainingArabicLableNumberOfRepetation,
    StringManager.trainingArabicLableRoundNumber,
    StringManager.trainingArabicLableInstruction,
    StringManager.trainingArabicLableVideoLink,
  ];
  TextEditingController trainingEnglishNameController = TextEditingController();
  TextEditingController trainingEnglishLevelController =
      TextEditingController();
  TextEditingController trainingEnglishNumberOfRepetationController =
      TextEditingController();
  TextEditingController trainingEnglishRoundNumberController =
      TextEditingController();
  TextEditingController trainingEnglishInstructionController =
      TextEditingController();

  TextEditingController trainingArabicNameController = TextEditingController();
  TextEditingController trainingArabicLevelController = TextEditingController();
  TextEditingController trainingArabicNumberOfRepetationController =
      TextEditingController();
  TextEditingController trainingArabicRoundNumberController =
      TextEditingController();
  TextEditingController trainingArabicInstructionController =
      TextEditingController();

  TextEditingController trainingVideoLinkController = TextEditingController();

//---------------------------------------------------------------------------------------------------
  var videoFilename;
  File? videoFile;
  var imagePicker = ImagePicker();
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
      trainingEnglishNumberOfRepetationController,
      trainingEnglishRoundNumberController,
      trainingEnglishInstructionController,
      trainingVideoLinkController
    ];
    return controllers;
  }

  List<TextEditingController> getTrainingArabicControllers() {
    List<TextEditingController> controllers = [
      trainingArabicNameController,
      trainingArabicLevelController,
      trainingArabicNumberOfRepetationController,
      trainingArabicRoundNumberController,
      trainingArabicInstructionController,
      trainingVideoLinkController
    ];
    return controllers;
  }
  setTrainingPeriod({required DateTime date})
  {
    trainingPeriod=date;
    emit(SetTrainingPeriod());
  }

  bool validateAddTraining() {
    if (trainingEnglishNameController.text.isEmpty) {
      getToastMessage(
        message: 'the english name field is empty',
      );
      return false;
    } else if (trainingArabicNameController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic name field is empty',
      );
      return false;
    } else if (trainingEnglishLevelController.text.isEmpty) {
      getToastMessage(
        message: 'the english level field is empty',
      );
      return false;
    } else if (trainingArabicLevelController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic level field is empty',
      );
      return false;
    } else if (trainingEnglishNumberOfRepetationController.text.isEmpty) {
      getToastMessage(
        message: 'the english number of reputation field is empty',
      );
      return false;
    } else if (trainingArabicNumberOfRepetationController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic number of reputation field is empty',
      );
      return false;
    } else if (trainingEnglishRoundNumberController.text.isEmpty) {
      getToastMessage(
        message: 'the english round number field is empty',
      );
      return false;
    } else if (trainingArabicRoundNumberController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic round number field is empty',
      );
      return false;
    } else if (trainingEnglishInstructionController.text.isEmpty) {
      getToastMessage(
        message: 'the english instruction field is empty',
      );
      return false;
    } else if (trainingArabicInstructionController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic instruction field is empty',
      );
      return false;
    } else if (trainingVideoLinkController.text.isEmpty) {
      getToastMessage(
        message: 'the video link field is empty',
      );
      return false;
    } else if (trainingPeriod.second == 0 &&
        trainingPeriod.minute == 0 &&
        trainingPeriod.hour == 0) {
      getToastMessage(
        message: 'the training period is not set',
      );
      return false;
    } else {
      return true;
    }
  }

  addNewTraining()
  {

      emit(AddNewTrainingLoadingState());
      CollectionReference data = FirebaseFirestore.instance.collection(StringManager.CollectionTrainings);
 data.add({
        StringManager.trainingEnglishName:trainingEnglishNameController.text,
        StringManager.trainingEnglishLevel:trainingEnglishLevelController.text,
        StringManager.trainingEnglishNumberOfReputation:trainingEnglishNumberOfRepetationController.text,
        StringManager.trainingEnglishRoundNumber:trainingEnglishRoundNumberController.text,
        StringManager.trainingEnglishInstruction:trainingEnglishInstructionController.text,

        StringManager.trainingArabicName:trainingArabicNameController.text,
        StringManager.trainingArabicLevel:trainingArabicLevelController.text,
        StringManager.trainingArabicNumberOfReputation:trainingArabicNumberOfRepetationController.text,
        StringManager.trainingArabicRoundNumber:trainingArabicRoundNumberController.text,
        StringManager.trainingArabicInstruction:trainingArabicInstructionController.text,

        StringManager.trainingVideoLink:trainingVideoLinkController.text,
        StringManager.trainingHourPeriod:trainingPeriod.hour,
        StringManager.trainingMinutePeriod:trainingPeriod.minute,
        StringManager.trainingSecondPeriod:trainingPeriod.second,
      }).then((value){
        emit(AddNewTrainingSuccessState());
 }).catchError((error){
   emit(AddNewTrainingErrorState());
   getToastMessage(
     message: 'a problem has happened',
   );
   print(error);
 });


  }

  processOfAddingTraining()
  {
    if(validateAddTraining())
      {
        addNewTraining();
      }
  }



  // Future<void> pickVideo()
  // async {
  //   emit(PickVideoLoadingState());
  //   final pickedFile=await imagePicker.pickVideo(source: ImageSource.gallery);
  //   if(pickedFile!=null)
  //   {
  //     videoFilename=pickedFile.path.split('/').last;
  //     videoFile=File(pickedFile.path);
  //     emit(PickVideoSuccessState());
  //   }
  //   else
  //   {
  //     print('no video selected');
  //     emit(PickVideoErrorState());
  //   }
  //
  // }
  // uploadFileToDrive() async {
  // await  googleDriveSevice.initSignIn();
  //   // if(videoFile!=null) {
  //   //   await googleDriveSevice.uploadFileToGoogleDrive(videoFile!);
  //   //   emit(UploadFileToDriveState());
  //   // }
  // }
}
