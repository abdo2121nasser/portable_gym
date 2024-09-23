import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/progress_models/activity_model.dart';
import 'package:my_coach/resourses/models/work_out_models/body_category_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/progress_tracking_blocks/body_block/charts_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/progress_tracking_blocks/body_block/work_out_log_body_block.dart';

part 'progress_tracking_state.dart';

class ProgressTrackingCubit extends Cubit<ProgressTrackingState> {
  ProgressTrackingCubit({required this.userDocId})
      : super(ProgressTrackingInitial()) {
    activities =
        box.get(StringManager.myDailyActivities, defaultValue: []) ?? [];
  }
  static ProgressTrackingCubit get(context) => BlocProvider.of(context);

  final box = Hive.box(StringManager.activityBox);
  List<dynamic> activities = []; // list<Activity>
  DateTime currentDate = DateTime.now();
  late String userDocId;
  int currentBodyLevel = 0;

  getBodyLevelLables(context) {
    return [
      S.of(context).workoutLog,
    //  S.of(context).charts,
    ];
  }

  getCurrentBody() {
    return [const WorkOutLogBodyBlock(),
    //  const ChartsBodyBlock()
    ];
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

  bool isActivityOfDay({required BodyCategoryModel model}) {
    for (var element in activities) {
      if (element.date.day == DateTime.now().day &&
          element.date.month == DateTime.now().month &&
          element.date.year == DateTime.now().year &&
          element.englishCategoryName == model.english!.title! &&
          element.userDocId == userDocId) {
        return true;
      }
    }
    return false;
  }

  void addActivityOfDay({required BodyCategoryModel model}) {
    emit(AddActivityOfDayLoadingState());
    activities.add(Activity(
        englishCategoryName: model.english!.title!,
        arabicCategoryName: model.arabic!.title!,
        date: DateTime.now(),
        period: DateTime(
          0,
          0,
          0,
          model.hour!,
          model.minute!,
          model.second!,
        ),
        userDocId: userDocId));

    box.put(StringManager.myDailyActivities, activities).then((value) {
      emit(AddActivityOfDaySuccessState());
    }).catchError((error) {
      emit(AddActivityOfDayErrorState());
      debugPrint(error.toString());
    });
  }

  void deleteActivityOfDay({required BodyCategoryModel model}) {
    emit(DeleteActivityOfDayLoadingState());
    for (var element in activities) {
      if (element.englishCategoryName == model.english!.title &&
          element.date.day == DateTime.now().day &&
          element.date.month == DateTime.now().month &&
          element.date.year == DateTime.now().year &&
          element.userDocId == userDocId) {
        activities.remove(element);
        break;
      }
    }
    box.put(StringManager.myDailyActivities, activities).then((value) {
      emit(DeleteActivityOfDaySuccessState());
    }).catchError((error) {
      emit(DeleteActivityOfDayErrorState());
      debugPrint(error.toString());
    });
  }

  List<Activity> getActivitiesOfDay() {
    List<Activity> tempActivities = [];
    for (var element in activities) {
      if (element.date.day == currentDate.day &&
          element.date.month == currentDate.month &&
          element.date.year == currentDate.year &&
          element.userDocId == userDocId) {
        tempActivities.add(element);
      }
    }
    return tempActivities;
  }
}
