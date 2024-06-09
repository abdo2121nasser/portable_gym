import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../managers_files/color_manager.dart';
import '../managers_files/font_manager.dart';
import '../managers_files/style_manager.dart';
import '../managers_files/values_manager.dart';
import 'general_text_form_field.dart';




class FullInputBlock extends StatelessWidget {
      final String lable;
      final Color color;

      FullInputBlock({required this.lable, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lable,
            style: getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: color,
                fontFamily: FontFamily.kPoppinsFont)),
        SizedBox(
          height: AppVerticalSize.s5,
        ),
        GeneralTextFormField(),
      ],
    );
  }
}
