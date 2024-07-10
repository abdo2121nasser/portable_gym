import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/recorded_unit_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/work_out_models/training_model.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import 'package:intl/intl.dart';


class RoundItemBlock extends StatelessWidget {
   final TrainingModel trainingModel;
   final VoidCallback deleteFunction;

   RoundItemBlock({required this.trainingModel,required this.deleteFunction});

   @override
  Widget build(BuildContext context) {
     var languageModel=trainingModel.getLanguageClass(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s10,horizontal: AppHorizontalSize.s16),
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s36)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.kLightPurpleColor,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.play_arrow_rounded,color: ColorManager.kWhiteColor,size: AppVerticalSize.s55,),
              ),
              SizedBox(width: AppHorizontalSize.s10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:AppVerticalSize.s16 ,
                    width: AppHorizontalSize.s100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s8),
                            child: Text(
                              languageModel.name.toString(),
                              style: getMeduimStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.kBlackColor,
                                  fontFamily: FontFamily.kPoppinsFont),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppVerticalSize.s5,),
                  SizedBox(
                      width: AppHorizontalSize.s100,
                      child: RecordedUnitBlock(
                        icon: Icons.timer,
                        mesuaringUnit:'',
                        unitValue: DateFormat('HH:mm:ss').format(DateTime(0,0,0,trainingModel.hour!,trainingModel.minute!,trainingModel.second!,)),
                        textColor: ColorManager.kLightPurpleColor,iconColor: ColorManager.kLightPurpleColor,)),

                ],
              ),

            ],
          ),
          Text(
            S.of(context).reputation+languageModel.numberOfReputation.toString()+'x',
            style: getMeduimStyle(
                fontSize: FontSize.s12,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
        InkWell(
            onTap: deleteFunction,
            child: Icon(Icons.delete,color: ColorManager.kRed,)),
          trainingModel.isPaid!?
          SizedBox(
              width: AppHorizontalSize.s22,
              height: AppVerticalSize.s22,
              child: Image.asset(ImageManager.kCrownImage)):SizedBox(),        ],
      ),
    );
  }
}
