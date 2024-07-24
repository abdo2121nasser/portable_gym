import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';
import '../../../generated/l10n.dart';

class FloatingActionButtonBlock extends StatelessWidget {
    final VoidCallback function;
    FloatingActionButtonBlock({required this.function});

    @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
          onPressed: function,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(AppRadiusSize.s22))),
          backgroundColor: ColorManager.kLightPurpleColor,
          child: Icon(
            Icons.add,
          ),
        );
  }


}
