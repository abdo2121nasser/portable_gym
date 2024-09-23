import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';


class PersonalInformationBlock extends StatelessWidget {
  final String fullName;
  final String email;

  const PersonalInformationBlock(
      {super.key, required this.fullName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          fullName,
          style: getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
        Text(
          email,
          style: getLightStyle(
              fontSize: FontSize.s14,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
      ],
    );
  }
}
