import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../managers_files/color_manager.dart';

class GeneralTextFormField extends StatelessWidget {
  final bool onlyInteger;
  final TextEditingController? controller;
  final bool enableBorder;
  final bool multiLine;
  final bool isArabic;
  final bool readOnly;
  final String? hint;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final VoidCallback? suffixIconFunction;
  final VoidCallback? prefixIconFunction;
 final bool isVisible;

  const GeneralTextFormField({
    super.key,
    this.onlyInteger = false,
    required this.controller,
    this.enableBorder = false,
    this.multiLine = false,
    this.isArabic = false,
    this.readOnly = false,
    this.isVisible=true,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconFunction,
    this.prefixIconFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      minLines: multiLine ? 1 : null,
      maxLines: multiLine ? 5 : 1, // Set maxLines to 4 if multiline is enabled
      keyboardType: multiLine ? TextInputType.multiline : null,
      textAlign: isArabic ? TextAlign.end : TextAlign.start,
      obscureText: !isVisible,
      inputFormatters: <TextInputFormatter>[
        if (onlyInteger)
          FilteringTextInputFormatter.allow(
            RegExp(r'^[\u0660-\u0669\u0030-\u0039]*\.?[\u0660-\u0669\u0030-\u0039]*$'),
          ),
      ],

      decoration: InputDecoration(
        fillColor: ColorManager.kWhiteColor,
        filled: true,
        hintText: hint,
        enabledBorder: enableBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppRadiusSize.s20),
          ),
          borderSide: BorderSide(
            width: AppHorizontalSize.s1_5,
            color: ColorManager.kBlackColor,
          ),
        )
            : null,
        focusedBorder: enableBorder
            ? OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppRadiusSize.s20),
          ),
          borderSide: BorderSide(
            width: AppHorizontalSize.s1_5,
            color: ColorManager.kBlackColor,
          ),
        )
            : null,
        suffixIcon: suffixIcon != null
            ? InkWell(
          onTap: () {
            suffixIconFunction!();
          },
          child: suffixIcon,
        )
            : null,
        prefixIcon: prefixIcon != null
            ? InkWell(
          onTap: () {
            prefixIconFunction!();
          },
          child: prefixIcon,
        )
            : null,
      ),
    );
  }
}
