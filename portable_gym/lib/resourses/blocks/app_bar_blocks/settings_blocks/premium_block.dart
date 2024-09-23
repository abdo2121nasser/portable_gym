import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';

class PremiumBlock extends StatelessWidget {
  const PremiumBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s30, vertical: AppVerticalSize.s5),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.asset(
              ImageManager.kCrownImage,
              width: AppHorizontalSize.s30,
            ),
            SizedBox(
              width: AppHorizontalSize.s22,
            ),
            Text(
              S.of(context).premium,
              style: getRegularStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
            )
          ],
        ),
      ),
    );
  }
}
