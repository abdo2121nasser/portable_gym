import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';

class FloatingActionButtonBlock extends StatefulWidget {
  @override
  State<FloatingActionButtonBlock> createState() =>
      _FloatingActionButtonBlockState();
}

class _FloatingActionButtonBlockState extends State<FloatingActionButtonBlock> {
  @override
  void initState() {
    GoogleDriveSevice googleDriveSevice = GoogleDriveSevice();
    googleDriveSevice.initSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var workCubit=WorkOutCubit.get(context);
        return FloatingActionButton(
          onPressed: () async {
            showAlertBox(context: context,tabBar: workCubit.trainingTabBar,tabBarVeiw: workCubit.tabBarView);
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
