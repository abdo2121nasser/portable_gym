import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';



class SectionTitleBlock extends StatelessWidget {
   final String sectionLable;

   SectionTitleBlock({required this.sectionLable});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            sectionLable ,
            style: getMeduimStyle(
                fontSize: FontSize.s16,
                color: ColorManager.kLimeGreenColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
          SizedBox(
            child:
            Row(
              children: [
                Text(
                  S.of(context).seeAll,
                  style: getMeduimStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
                const Icon(Icons.arrow_right,color: ColorManager.kLimeGreenColor,)

              ],
            ),
          )

        ],
      ),
    );
  }
}
