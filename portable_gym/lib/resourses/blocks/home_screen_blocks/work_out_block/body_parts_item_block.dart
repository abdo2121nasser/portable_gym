import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/work_out_models/body_category_model.dart';
import '../../general_blocks/recorded_unit_block.dart';
import 'package:intl/intl.dart';
class BodyPartItemBlock extends StatelessWidget {
  final BodyCategoryModel bodyCategoryModel;
  final VoidCallback deleteFunction;
  BodyPartItemBlock(
      {required this.bodyCategoryModel, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    var languageModel = bodyCategoryModel.getLanguageClass(context);
    DateTime dateTime=DateTime(0,0,0,bodyCategoryModel.hour!,bodyCategoryModel.minute!,bodyCategoryModel.second!,);

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Text(
                    languageModel.title!,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                        fontSize: FontSize.s18,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont),
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
                          unitValue:DateFormat('HH:mm:ss').format(dateTime),
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
                          mesuaringUnit: S.of(context).exercises,
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
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppHorizontalSize.s30),
                            child: CircularProgressIndicator(
                              color: ColorManager.kBlue,
                            ),
                          ),
                        );
                      }
                    },
                    height: constrain.maxHeight,
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: AppVerticalSize.s30,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppHorizontalSize.s10,vertical: AppVerticalSize.s5),
                        child: InkWell(
                          onTap: deleteFunction,
                          child: Icon(
                            Icons.delete,
                            color: ColorManager.kRed,
                          ),
                        ),
                      ),
                    ],
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
