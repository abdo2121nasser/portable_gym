import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/image_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/work_out_models/body_category_model.dart';
import '../../resource_screen_blocks/recorded_unit_block.dart';

class BodyPartBlock extends StatelessWidget {
  final BodyCategoryModel bodyCategoryModel;
  BodyPartBlock({
    required this.bodyCategoryModel,
  });

  @override
  Widget build(BuildContext context) {
    var languageModel = bodyCategoryModel.getLanguageClass(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
      decoration: BoxDecoration(
          color: ColorManager.kWhiteColor,
          borderRadius: BorderRadius.circular(AppRadiusSize.s36)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.49,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          languageModel.title!,
                          textAlign: TextAlign.center,
                          style: getMeduimStyle(
                              fontSize: FontSize.s18,
                              color: ColorManager.kBlackColor,
                              fontFamily: FontFamily.kPoppinsFont),
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  children: [
                    SizedBox(
                        width: AppHorizontalSize.s90,
                        height: AppVerticalSize.s22,
                        child: RecordedUnitBlock(
                          icon: Icons.timer,
                          mesuaringUnit: S.of(context).minuteWord,
                          unitValue: bodyCategoryModel.minute.toString(),
                          iconColor: ColorManager.kBlackColor,
                          textColor: ColorManager.kBlackColor,
                        )),
                    SizedBox(
                        width: AppHorizontalSize.s90,
                        height: AppVerticalSize.s22,
                        child: RecordedUnitBlock(
                          icon: Icons.local_fire_department,
                          mesuaringUnit: S.of(context).kCal,
                          unitValue: languageModel.calories!,
                          iconColor: ColorManager.kBlackColor,
                          textColor: ColorManager.kBlackColor,
                        )),
                    SizedBox(
                        width: AppHorizontalSize.s90,
                        height: AppVerticalSize.s22,
                        child: RecordedUnitBlock(
                          icon: Icons.directions_run_outlined,
                          mesuaringUnit:  S.of(context).exercises,
                          unitValue: languageModel.numberOfExercises!,
                          iconColor: ColorManager.kBlackColor,
                          textColor: ColorManager.kBlackColor,
                        )),
                  ],
                ),
              ],
            ),
          ),
          LayoutBuilder(builder: (context, constrain) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppRadiusSize.s36),
                  ),
                  child: Image.network(
                    bodyCategoryModel.imageLink!,
                    height: constrain.maxHeight,
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppRadiusSize.s16),
                  child: Icon(
                    Icons.star_rounded,
                    color: ColorManager.kWhiteColor,
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
