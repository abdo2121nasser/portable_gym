import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class CheckBoxBlock extends StatelessWidget {
  final bool? value;
  final bool isArabic;
  final String lable;
  final Color borderColor;
  final TextStyle textStyle;
  final Function(bool?)? checkBoxFunction;
  final VoidCallback? alertBoxFunction;
  final bool isSqecialCheckBox;
  const CheckBoxBlock(
      {super.key,
      required this.value,
       this.checkBoxFunction,
        this.borderColor=ColorManager.kBlackColor,
      required this.lable,
      required this.textStyle,
      this.isArabic = false,
      this.isSqecialCheckBox=false,
        this.alertBoxFunction
      });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isSqecialCheckBox?
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s5),
                 child: InkWell(
                   onTap: (){},
                   child: const Icon(Icons.open_in_new_rounded,
              color: ColorManager.kWhiteColor,),
                 ),
               )
              :
          Checkbox(
            shape:  const CircleBorder(),
            value: value,
            onChanged: checkBoxFunction,
            side: BorderSide(color:borderColor ),
          ),
          Flexible(
            child: Text(
              lable,
              style: textStyle,
              textAlign: isArabic ? TextAlign.end : TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
