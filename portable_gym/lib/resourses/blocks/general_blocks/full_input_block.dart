import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import 'general_text_form_field.dart';

class FullInputBlock extends StatelessWidget {
  final String lable;
  final Color color;
  final TextEditingController controller;
  final bool enableBorder;
  final bool isArabicTabView;
  final bool isNormalInput;
  final bool multiLine;
  final bool onlyInteger;
  final bool readOnly;

  const FullInputBlock({super.key,
    required this.lable,
    required this.color,
    required this.controller,
    this.readOnly = false,
    this.enableBorder = false,
    this.isArabicTabView = false,
    this.isNormalInput = false,
    this.multiLine = false,
    this.onlyInteger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Directionality(
          textDirection: isNormalInput == true
              ? Get.locale!.languageCode.toString() == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl
              : isArabicTabView
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          child: Row(
            children: [
              Text(
                lable,
                style: getSemiBoldStyle(
                  fontSize: FontSize.s16,
                  color: color,
                  fontFamily: FontFamily.kPoppinsFont,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppVerticalSize.s5,
        ),
        GeneralTextFormField(
          controller: controller,
          enableBorder: enableBorder,
          onlyInteger: onlyInteger,
          isArabic: isArabicTabView,
          readOnly: readOnly,
          multiLine: multiLine,
        ),
      ],
    );
  }
}
