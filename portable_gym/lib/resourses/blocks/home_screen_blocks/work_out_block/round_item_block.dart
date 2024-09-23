import 'package:flutter/material.dart';
import 'package:my_coach/resourses/blocks/general_blocks/recorded_unit_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/image_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';
import 'package:my_coach/resourses/models/profile_models/profile_model.dart';
import 'package:my_coach/resourses/models/work_out_models/training_model.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import 'package:intl/intl.dart';

class RoundItemBlock extends StatelessWidget {
  final TrainingModel trainingModel;
  final VoidCallback deleteFunction;
  final VoidCallback addToFavouriteFunction;
  final VoidCallback deleteFavouriteFunction;
  final bool isTrainingFavourite;
  final bool isDailyTraining;
  final ProfileModel profileModel;

  const RoundItemBlock(
      {super.key,
      required this.trainingModel,
      required this.deleteFunction,
      required this.addToFavouriteFunction,
      required this.deleteFavouriteFunction,
      required this.isTrainingFavourite,
      required this.isDailyTraining,
      required this.profileModel
      });

  @override
  Widget build(BuildContext context) {
    var languageModel = trainingModel.getLanguageClass(context);

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppVerticalSize.s10, horizontal: AppHorizontalSize.s16),
      decoration: BoxDecoration(
          color: ColorManager.kWhiteColor,
          borderRadius: BorderRadius.circular(AppRadiusSize.s36)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: ColorManager.kLightPurpleColor,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: ColorManager.kWhiteColor,
                  size: AppVerticalSize.s55,
                ),
              ),
              // SizedBox(
              //   width: AppHorizontalSize.s10,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppVerticalSize.s24,
                    width: AppHorizontalSize.s120,
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppHorizontalSize.s8),
                            child: Text(
                             languageModel.name.toString(),
                              style: getMediumStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.kBlackColor,
                                  fontFamily: FontFamily.kPoppinsFont),

                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                      width: AppHorizontalSize.s120,
                      child: RecordedUnitBlock(
                        icon: Icons.timer,
                        mesuaringUnit: '',
                        unitValue:
                            '${S.of(context).rest} ${S.of(context).from} ${trainingModel.startPeriod} ${S.of(context).to} ${trainingModel.endPeriod!}',
                        textColor: ColorManager.kLightPurpleColor,
                        iconColor: ColorManager.kLightPurpleColor,
                      )),
                ],
              ),
            ],
          ),
          Text(
            '${languageModel.numberOfRounds} x ${languageModel.numberOfReputation} ${S.of(context).reputationShort}',
            style: getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
          trainingModel.isPaid!
              ? Flexible(
                  child: SizedBox(
                      width: AppHorizontalSize.s22,
                      height: AppVerticalSize.s22,
                      child: Image.asset(ImageManager.kCrownImage)),
                )
              : const SizedBox(),
          !isDailyTraining
              ? Flexible(
                  child: InkWell(
                      onTap: isTrainingFavourite
                          ? deleteFavouriteFunction
                          : addToFavouriteFunction,
                      child: Icon(
                        isTrainingFavourite
                            ? Icons.star_rounded
                            : Icons.star_border,
                        color: ColorManager.kPurpleColor,
                      )),
                )
              : const SizedBox(),
       profileModel.isClient==false?
          InkWell(
              onTap: deleteFunction,
              child: Icon(
                Icons.delete,
                color: ColorManager.kRed,
              )):const SizedBox(),
        ],
      ),
    );
  }
}
