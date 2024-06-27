import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';

import '../../generated/l10n.dart';

part 'work_out_state.dart';

class WorkOutCubit extends Cubit<WorkOutState> {
  WorkOutCubit() : super(WorkOutInitial());
  static WorkOutCubit get(context) => BlocProvider.of(context);
  GoogleDriveSevice? googleDriveSevice;
  getCategoryLabels({required int index,required context}) {
    List<String> lables = [
      S.of(context).beginner,
      S.of(context).intermediate,
      S.of(context).advanced,
    ];
    return lables[index];
  }
  uploadFileToDrive({required File file})
  {
    googleDriveSevice!.uploadFileToGoogleDrive(file);
    emit(UploadFileToDriveState());
  }

}
