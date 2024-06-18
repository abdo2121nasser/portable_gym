import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';


class RecordedUnitBlock extends StatelessWidget {
  final Color iconColor,textColor;


  RecordedUnitBlock({this.iconColor=ColorManager.kPurpleColor,this.textColor=ColorManager.kWhiteColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s5),
          child: Icon(Icons.timer,color: iconColor,size: FontSize.s12,),
        ),
        Expanded(
          child: Text(
            '12 Minites' ,
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
