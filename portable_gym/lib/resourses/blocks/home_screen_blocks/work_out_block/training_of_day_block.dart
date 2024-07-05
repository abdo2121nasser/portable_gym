import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/image_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../resource_screen_blocks/recorded_unit_block.dart';

class TrainingOfDayBlock extends StatelessWidget {
  final String trainingName;

  TrainingOfDayBlock({required this.trainingName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.33,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        color: ColorManager.kLightPurpleColor,
      ),
      child: LayoutBuilder(builder: (context, constrain) {
        return Container(
          width: constrain.maxWidth*0.9,
            decoration: BoxDecoration(
                color: ColorManager.kBlackColor,
                borderRadius: BorderRadius.circular(AppRadiusSize.s20),
                image: DecorationImage(
                    image: Image.asset(ImageManager.kTrainningImage).image,
                    fit: BoxFit.fill)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(AppRadiusSize.s4),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppRadiusSize.s20),
                            color: ColorManager.kLimeGreenColor),
                        child: Text(
                          S.of(context).trainingOfDay,
                          textAlign: TextAlign.center,
                          style: getMeduimStyle(
                              fontSize: FontSize.s12,
                              color: ColorManager.kBlackColor,
                              fontFamily: FontFamily.kLeagueSpartanFont),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: constrain.maxHeight * 0.25,
                    width: constrain.maxWidth,
                    decoration: BoxDecoration(
                      color: ColorManager.kTransparantBlackColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(AppRadiusSize.s20),
                          bottomLeft: Radius.circular(AppRadiusSize.s20)),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: constrain.maxWidth * 0.56,
                              height: constrain.maxHeight*0.13,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                     trainingName,
                                      textAlign: TextAlign.start,
                                      style: getMeduimStyle(
                                          fontSize: FontSize.s14,
                                          color: ColorManager
                                              .kLimeGreenColor,
                                          fontFamily:
                                              FontFamily.kPoppinsFont),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: constrain.maxWidth * 0.7,
                              height: constrain.maxHeight*0.12,
                              child: ListView.separated(

                                scrollDirection:Axis.horizontal,

                                itemBuilder: (context, index) => SizedBox(
                                    width: constrain.maxWidth * 0.23,
                                    height: constrain.maxHeight*0.12,
                                    child: RecordedUnitBlock(  icon: Icons.timer,
                                      mesuaringUnit: 'minute',
                                      unitValue: '45',),),
                              separatorBuilder: (context, index) => SizedBox(width: AppHorizontalSize.s5,),
                              itemCount: 3,),
                            )
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s10),
                          child: Icon(Icons.star_rounded,color: ColorManager.kWhiteColor,),
                        )
                      ],
                    ),
                  )
                ]));
      }),
    );
  }
}
