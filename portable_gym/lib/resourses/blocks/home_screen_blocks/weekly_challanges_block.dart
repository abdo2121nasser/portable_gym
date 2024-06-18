import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/font_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/style_manager.dart';

class WeeklyChallangesBlock extends StatelessWidget {
            final String title;
            final String lable;

            WeeklyChallangesBlock({required this.title,required this.lable});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.23,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        color: ColorManager.kLightPurpleColor,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.kBlackColor,
            borderRadius: BorderRadius.circular(AppRadiusSize.s20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.38,
                    height:  MediaQuery.of(context).size.height*0.1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: getMeduimStyle(
                                fontSize: FontSize.s24,
                                color: ColorManager.kLimeGreenColor,
                                fontFamily: FontFamily.kPoppinsFont),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.38,
                    height:  MediaQuery.of(context).size.height*0.05,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            lable,
                            textAlign: TextAlign.center,
                            style: getMeduimStyle(
                                fontSize: FontSize.s12,
                                color: ColorManager.kWhiteColor,
                                fontFamily: FontFamily.kPoppinsFont),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            LayoutBuilder(builder: (context, constrain) {
              return ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppRadiusSize.s12),
                ),
                child: Image.asset(
                  ImageManager.kSmileManImage,
                  height: constrain.maxHeight,
                  width: MediaQuery.of(context).size.width * 0.45,
                  fit: BoxFit.cover,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
