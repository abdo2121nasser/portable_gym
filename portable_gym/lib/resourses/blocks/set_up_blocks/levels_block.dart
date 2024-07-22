import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';





class LevelsBlock extends StatelessWidget {
  const LevelsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s12),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.s36),
        color: ColorManager.kWhiteColor
      ),
      child: Text(
        S.of(context).enterYourWeight,
        style: getMediumStyle(
            fontSize: FontSize.s22,
            color: ColorManager.kPurpleColor,
            fontFamily: FontFamily.kLeagueSpartanFont),
        textAlign: TextAlign.center,
      ),

    );
  }
}
