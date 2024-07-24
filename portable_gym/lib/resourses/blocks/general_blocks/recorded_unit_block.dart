import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class RecordedUnitBlock extends StatelessWidget {
  final Color iconColor, textColor;
  final IconData icon;
  final String mesuaringUnit, unitValue;

  RecordedUnitBlock(
      {this.iconColor = ColorManager.kPurpleColor,
      this.textColor = ColorManager.kWhiteColor,
      required this.icon,
      required this.mesuaringUnit,
      required this.unitValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s5),
          child: Icon(
            icon,
            color: iconColor,
            size: FontSize.s12,
          ),
        ),
        Flexible(
          child: Text(
            unitValue+' '+mesuaringUnit,
            style: getLightStyle(
                fontSize: FontSize.s12,
                color: textColor,
                fontFamily: FontFamily.kLeagueSpartanFont),
          ),
        ),
      ],
    );
  }
}
