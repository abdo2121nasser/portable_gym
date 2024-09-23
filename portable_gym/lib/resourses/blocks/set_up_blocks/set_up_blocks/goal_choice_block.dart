import 'package:flutter/material.dart';
import 'package:my_coach/resourses/blocks/general_blocks/check_box_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';






class GoalChoiceBlock extends StatelessWidget {
    final String title;
    final bool value;

    GoalChoiceBlock({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.s36),
        color: ColorManager.kWhiteColor
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: getRegularStyle(
                    fontSize: FontSize.s18,
                    color: ColorManager.kBlackColor,
                    fontFamily: FontFamily.kLeagueSpartanFont)),
            RoundCheckBox(
              onTap: null,
              isChecked: value,

              border: Border.all(width: AppHorizontalSize.s2),
             // uncheckedColor: ColorManager.kWhiteColor,
              disabledColor: ColorManager.kPurpleColor,

            ),

          ],
        ),
      ),
    );
  }
}
