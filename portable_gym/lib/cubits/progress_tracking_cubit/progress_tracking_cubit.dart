import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/progress_tracking_blocks/body_block/charts_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/progress_tracking_blocks/body_block/work_out_log_body_block.dart';

part 'progress_tracking_state.dart';

class ProgressTrackingCubit extends Cubit<ProgressTrackingState> {
  ProgressTrackingCubit() : super(ProgressTrackingInitial());
  static ProgressTrackingCubit get(context) => BlocProvider.of(context);

  DateTime currentDate = DateTime.now();
  int currentBodyLevel = 0;
  List<Widget> bodies = [WorkOutLogBodyBlock(), ChartsBodyBlock()];

  getBodyLevelLables(context) {
    return [
      S.of(context).workoutLog,
      S.of(context).charts,
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
}
