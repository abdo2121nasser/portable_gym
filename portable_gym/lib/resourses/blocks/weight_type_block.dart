import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../managers_files/color_manager.dart';
import '../managers_files/font_manager.dart';
import '../managers_files/style_manager.dart';
import '../managers_files/values_manager.dart';

class WeightTypeBlock extends StatelessWidget {
  const WeightTypeBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
      height: AppVerticalSize.s55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusSize.s14),
          color: ColorManager.kLimeGreenColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            S.of(context).kg,
            style: getBoldStyle(
                fontSize: FontSize.s14,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kPoppinsFont),
            textAlign: TextAlign.center,
          ),
          VerticalDivider(
            color: ColorManager.kBlackColor,
            thickness: AppHorizontalSize.s3,
            indent: AppVerticalSize.s5,
            endIndent: AppVerticalSize.s5,
          ),
          Text(
            S.of(context).lb,
            style: getBoldStyle(
                fontSize: FontSize.s14,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kPoppinsFont),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
