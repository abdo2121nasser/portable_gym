import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portable_gym/resourses/models/nutrition_models/daily_recipe_card_model.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/google_drive_function_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import '../../models/work_out_models/body_category_model.dart';
import 'recorded_unit_block.dart';
import 'package:intl/intl.dart';

class DailyActivityBlock extends StatelessWidget {
  final BodyCategoryModel? bodyCategoryModel;
  final DailyRecipeCardModel? dailyRecipeCardModel;
  final String title;
  final bool isDailyTraining;
  const DailyActivityBlock(
      {super.key, this.bodyCategoryModel,
        this.dailyRecipeCardModel,
      required this.title,
      this.isDailyTraining = true});

  @override
  Widget build(BuildContext context) {
    var languageModel;
    if (isDailyTraining) {
      languageModel = bodyCategoryModel!.getLanguageClass(context);
    }
    else
      {
        languageModel= dailyRecipeCardModel!.getLanguageClass(context);
      }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.03),
      decoration: const BoxDecoration(
        color: ColorManager.kLightPurpleColor,
      ),
      child: LayoutBuilder(builder: (context, constrain) {
        return Container(
            width: constrain.maxWidth * 0.9,
            decoration: BoxDecoration(
                color: ColorManager.kBlackColor,
                borderRadius: BorderRadius.circular(AppRadiusSize.s20),
                image: DecorationImage(
                    image: Image.network(isDailyTraining?
                                bodyCategoryModel!.imageLink!:
                    dailyRecipeCardModel!.imageLink)
                            .image,

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
                          title,
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: constrain.maxWidth * 0.56,
                              height: constrain.maxHeight * 0.13,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      isDailyTraining
                                          ? languageModel.title.toString()
                                          : languageModel.name,
                                      textAlign: TextAlign.start,
                                      style: getMediumStyle(
                                          fontSize: FontSize.s14,
                                          color: ColorManager.kLimeGreenColor,
                                          fontFamily: FontFamily.kPoppinsFont),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: constrain.maxWidth * 0.8,
                              height: constrain.maxHeight * 0.12,
                              child: isDailyTraining
                                  ? Row(
                                      children: [
                                        SizedBox(
                                            width: AppHorizontalSize.s90,
                                            height: AppVerticalSize.s22,
                                            child: RecordedUnitBlock(
                                              icon: Icons.timer,
                                              mesuaringUnit:'',
                                              unitValue: DateFormat('HH:mm:ss')
                                                  .format(DateTime(
                                                0,
                                                0,
                                                0,
                                                bodyCategoryModel!.hour!,
                                                bodyCategoryModel!.minute!,
                                                bodyCategoryModel!.second!,
                                              )),
                                            )),
                                        SizedBox(
                                            width: AppHorizontalSize.s90,
                                            height: AppVerticalSize.s22,
                                            child: RecordedUnitBlock(
                                              icon: Icons.local_fire_department,
                                              mesuaringUnit: S.of(context).kCal,
                                              unitValue: isDailyTraining
                                                  ? languageModel.calories!
                                                  : '50',
                                            )),
                                        SizedBox(
                                            width: AppHorizontalSize.s90,
                                            height: AppVerticalSize.s22,
                                            child: RecordedUnitBlock(
                                              icon:
                                                  Icons.directions_run_outlined,
                                              mesuaringUnit:
                                                  S.of(context).exercises,
                                              unitValue: isDailyTraining
                                                  ? languageModel
                                                      .numberOfExercises!
                                                  : "4",
                                            )),
                                      ],
                                    )
                                  : SizedBox(
                                      width: AppHorizontalSize.s90,
                                      height: AppVerticalSize.s22,
                                      child: RecordedUnitBlock(
                                        icon: Icons.local_fire_department,
                                        mesuaringUnit: S.of(context).kCal,
                                        unitValue: languageModel.calories,
                                      )),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ]));
      }),
    );
  }
}
