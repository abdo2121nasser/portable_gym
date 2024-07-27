import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/check_box_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';






class GoalChoiceBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.s36),
        color: ColorManager.kWhiteColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(S.of(context).whatsYourGoal,
              style: getRegularStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kLeagueSpartanFont)),
          RoundCheckBox(
            onTap: (selected) {
            },

            border: Border.all(width: AppHorizontalSize.s2),
            uncheckedColor: ColorManager.kWhiteColor,
          ),

        ],
      ),
    );
  }
}
