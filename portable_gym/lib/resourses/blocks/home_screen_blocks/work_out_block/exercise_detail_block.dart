import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/work_out_models/training_model.dart';

import '../../../../generated/l10n.dart';
import '../../general_blocks/recorded_unit_block.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import 'package:intl/intl.dart';

class ExerciseDetailBlock extends StatelessWidget {
        final TrainingModel trainingModel;

        ExerciseDetailBlock({required this.trainingModel});

  @override
  Widget build(BuildContext context) {
    var languageModel=trainingModel.getLanguageClass(context);
    DateTime dateTime=DateTime(0,0,0,trainingModel.hour!,trainingModel.minute!,trainingModel.second!,);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManager.kLimeGreenColor,
          borderRadius: BorderRadius.circular(AppRadiusSize.s22)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: AppVerticalSize.s30,
            child: Text(
              languageModel.name.toString(),
              style: getMeduimStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kPoppinsFont),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: AppVerticalSize.s44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      languageModel.instructions.toString(),
                      style: getMeduimStyle(
                          fontSize: FontSize.s12,
                          color: ColorManager.kBlackColor,
                          fontFamily: FontFamily.kPoppinsFont),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorManager.kWhiteColor,
                borderRadius: BorderRadius.circular(AppRadiusSize.s36)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: RecordedUnitBlock(
                      icon: Icons.timer,
                      mesuaringUnit:'',
                      unitValue:DateFormat('HH:mm:ss').format(dateTime),
                      textColor: ColorManager.kBlackColor,
                      iconColor: ColorManager.kBlackColor,
                    )),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.27,
                    child: RecordedUnitBlock(
                      icon: Icons.local_fire_department_outlined,
                      mesuaringUnit: S.of(context).reputation,
                      unitValue: languageModel.numberOfReputation.toString(),
                      textColor: ColorManager.kBlackColor,
                      iconColor: ColorManager.kBlackColor,
                    )),],
            ),
          )
        ],
      ),
    );
  }
}
