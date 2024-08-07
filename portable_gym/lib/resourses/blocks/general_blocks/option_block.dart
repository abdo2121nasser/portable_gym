import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class OptionBlock extends StatelessWidget {
  final  String lable;
  final IconData icon;

  const OptionBlock({super.key, required this.lable,required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(AppVerticalSize.s5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.kPurpleColor
                ),
                child:  Icon(icon,color: ColorManager.kWhiteColor,)),
            Padding(
              padding:  EdgeInsets.only(left: AppHorizontalSize.s16),
              child: Text(
                lable,
                style: getRegularStyle(
                    fontSize: FontSize.s20,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
            ),
          ],
        ),
        const Icon(
          Icons.arrow_right,
          color: ColorManager.kLimeGreenColor,
        ),


      ],
    );
  }
}
