import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/progress_models/activity_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/progress_tracking_blocks/body_block/charts_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/progress_tracking_blocks/body_block/work_out_log_body_block.dart';

part 'progress_tracking_state.dart';

class ProgressTrackingCubit extends Cubit<ProgressTrackingState> {
  ProgressTrackingCubit() : super(ProgressTrackingInitial())  {
  activities= box.get(StringManager.myDailyActivities,defaultValue:[])!;
  }
  static ProgressTrackingCubit get(context) => BlocProvider.of(context);

  List<Activity> activities=[];
  var box=Hive.box<List<Activity>>(StringManager.activityBox);
  DateTime currentDate = DateTime.now();
  int currentBodyLevel = 0;

  getBodyLevelLables(context) {
    return [
      S.of(context).workoutLog,
      S.of(context).charts,
    ];
  }

  getCurrentBody() {
    return [const WorkOutLogBodyBlock(), const ChartsBodyBlock()];
  }

  changeCurrentBodyIndex({required int index}) {
    currentBodyLevel = index;
    emit(ChangeCurrentBodyIndex());
  }

  selectDateTime(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(SelectDateTime());
    }
  }
  addActivityOfDay(){
    emit(AddActivityOfDayLoadingState());
    box.put(StringManager.myDailyActivities, activities).then((value) {
      emit(AddActivityOfDayLoadingState());
    }).catchError((error){
      emit(AddActivityOfDayLoadingState());
debugPrint(error);
    });
  }
 Activity? getActivityOfDay({required String myDocId}) {
    Activity activity;
    for (var element in activities)
      {
        if(element.date.day==DateTime.now().day&&
            element.date.month==DateTime.now().month&&
            element.date.year==DateTime.now().year&&
            element.userDocId==myDocId
        )
        {
          return element;
        }
      }
    return null;
  }



}
