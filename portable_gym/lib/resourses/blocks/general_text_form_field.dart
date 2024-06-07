import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../managers_files/color_manager.dart';


class GeneralTextFormField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppVerticalSize.s55,
      child: TextFormField(

        decoration: InputDecoration(
            fillColor: ColorManager.kWhiteColor,
            filled: true
        ),
      ),
    );
  }
}
