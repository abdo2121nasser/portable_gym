import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class CheckBoxBlock extends StatelessWidget {
  final bool value;
  final bool isArabic;
  final String lable;
  final Function(bool?) function;
  CheckBoxBlock(
      {required this.value,
      required this.function,
      required this.lable,
      this.isArabic = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppHorizontalSize.s140,
      child: Row(
        mainAxisAlignment:
            isArabic ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isArabic
              ? SizedBox(
            width: AppHorizontalSize.s30,
            child: Checkbox(
              shape: CircleBorder(),
              value: value,
              onChanged: function,
            ),
          )
              : SizedBox(),
          Text(
            lable,
            style: getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kPoppinsFont),
            textAlign: isArabic ? TextAlign.end : TextAlign.start,
          ),
          isArabic
              ? SizedBox()
              : SizedBox(
            width: AppHorizontalSize.s30,
                child: Checkbox(
                    shape: CircleBorder(),
                    value: value,
                    onChanged: function,
                  ),
              )
        ],
      ),
    );
  }
}
