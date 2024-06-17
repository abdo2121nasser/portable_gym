import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../generated/l10n.dart';

class MainNavigationBarScreen extends StatelessWidget {
  const MainNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        toolbarHeight: AppVerticalSize.s80,
        backgroundColor: ColorManager.kBlackColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 200,
                  child: Text(
                    'hi ahmed',
                    style: getBoldStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kPurpleColor,
                        fontFamily: FontFamily.kPoppinsFont),
                  ),
                ),

                const Icon(
                  Icons.person,
                  color: ColorManager.kPurpleColor,
                ),
                SizedBox(
                  width: AppHorizontalSize.s10,
                ),
              ],
            ),
            SizedBox(height: AppVerticalSize.s5,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).subTitle,
                    style: getMeduimStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kLeagueSpartanFont),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
