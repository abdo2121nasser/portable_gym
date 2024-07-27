import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/color_manager.dart';

class GeneralTextFormField extends StatelessWidget {
  final bool onlyInteger;
  final TextEditingController? controller;
  final bool enableBorder;
  final bool multiLine;
  final bool isArabic;
  final bool readOnly;
  GeneralTextFormField(
      {this.onlyInteger = false,
      required this.controller,
      this.enableBorder = false,
      this.multiLine = false,
      this.isArabic = false,
      this.readOnly=false
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppVerticalSize.s55,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        minLines: multiLine ? 1 : null,
        maxLines: multiLine ? 2 : null,
        keyboardType: multiLine ? TextInputType.multiline : null,
        textAlign: isArabic ? TextAlign.end : TextAlign.start,
        inputFormatters: <TextInputFormatter>[
          //if (onlyInteger) FilteringTextInputFormatter.digitsOnly,
          if (onlyInteger)
            FilteringTextInputFormatter.allow(
                // RegExp(r'^[\u0660-\u0669\d]+$'),

                RegExp(
                    r'^[\u0660-\u0669\u0030-\u0039]*\.?[\u0660-\u0669\u0030-\u0039]*$')),
        ],
        decoration: InputDecoration(
          fillColor: ColorManager.kWhiteColor,
          filled: true,
          enabledBorder: enableBorder
              ? OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadiusSize.s20)),
                  borderSide: BorderSide(
                      width: AppHorizontalSize.s1_5,
                      color: ColorManager.kBlackColor))
              : null,
          focusedBorder: enableBorder
              ? OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadiusSize.s20)),
                  borderSide: BorderSide(
                      width: AppHorizontalSize.s1_5,
                      color: ColorManager.kBlackColor))
              : null,
        ),
      ),
    );
  }
}
