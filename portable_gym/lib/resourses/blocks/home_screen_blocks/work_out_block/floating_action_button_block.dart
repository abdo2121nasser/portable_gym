import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';

class FloatingActionButtonBlock extends StatefulWidget {
  @override
  State<FloatingActionButtonBlock> createState() => _FloatingActionButtonBlockState();
}

class _FloatingActionButtonBlockState extends State<FloatingActionButtonBlock> {
 @override
  void initState() {
    GoogleDriveSevice googleDriveSevice=GoogleDriveSevice();
    googleDriveSevice.initSignIn();
  }

  @override

  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {

   // await pickImage();
    //await google.uploadFileToGoogleDrive(imageFile!);
      },
      child: Icon(
        Icons.add,
      ),
    );
  }
}
