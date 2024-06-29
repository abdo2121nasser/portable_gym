import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';
import '../../../../generated/l10n.dart';

class FloatingActionButtonBlock extends StatelessWidget {

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
        var workCubit = WorkOutCubit.get(context);
        return FloatingActionButton(
          onPressed: () async {
            showAlertBox(
                context: context,
                tabBar: trainingTabBar,
                tabBarView: workCubit.tabBarView,
                trainingPeriod: workCubit.trainingPeriod,
              processOfAddingTraining: workCubit.processOfAddingTraining
            );
            // await pickImage();
            //await google.uploadFileToGoogleDrive(imageFile!);
          },
          child: Icon(
            Icons.add,
          ),
        );
      },
    );
  }
}
