import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portable_gym/resourses/blocks/resource_screen_blocks/recorded_unit_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class ResourceElementBlock extends StatelessWidget {
         final String? image;
         final String? recordUnit1,recordUnit2;
         final String? title;
         final video;

         ResourceElementBlock({this.image, this.recordUnit1,this.recordUnit2, this.title, this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppHorizontalSize.s178,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.s16),
        border: Border.all(
            color: ColorManager.kWhiteColor, width: AppHorizontalSize.s1_5),
      ),
      child: LayoutBuilder(builder: (context, constrain) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppRadiusSize.s12),
                      topRight: Radius.circular(AppRadiusSize.s12)),
                  child: Image.asset(
                    ImageManager.kSmileManImage,
                    height: constrain.maxHeight * 0.57,
                    width: constrain.maxWidth,
                    fit: BoxFit.fill,
                  ),
                ),
             SizedBox(
               height: constrain.maxHeight*0.4,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Padding(
                     padding:
                     EdgeInsets.symmetric(horizontal: AppHorizontalSize.s5),
                     child: SizedBox(
                       height: constrain.maxHeight * 0.2,
                       child: Row(
                         children: [
                           Expanded(
                             child: Text(
                               'squat Exercise',
                               style: getRegularStyle(
                                   fontSize: FontSize.s16,
                                   color: ColorManager.kLimeGreenColor,
                                   fontFamily: FontFamily.kPoppinsFont),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                   Row(
                     children: [
                       SizedBox(
                           width: constrain.maxWidth * 0.45,
                           height: constrain.maxHeight*0.15,
                           child:  RecordedUnitBlock()),
                       SizedBox(
                           width: constrain.maxWidth * 0.45,
                           height: constrain.maxHeight*0.15,

                           child:  RecordedUnitBlock()),
                     ],
                   )
                 ],
               ),
             )
              ],
            ),
            Positioned(
              right: constrain.maxWidth * 0.08,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: ColorManager.kWhiteColor,
                    ),
                    SizedBox(
                      height: constrain.maxHeight * 0.28,
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            color: ColorManager.kPurpleColor,
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: ColorManager.kWhiteColor,
                        ))
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
