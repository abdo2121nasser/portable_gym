import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/profile_models/profile_model.dart';
import '../../../models/work_out_models/body_category_model.dart';
import '../../general_blocks/recorded_unit_block.dart';
import 'package:intl/intl.dart';

class BodyPartItemBlock extends StatelessWidget {
  final ProfileModel profileModel;
  final bool isSelected;
  final Function(BodyCategoryModel) addToActivityOfDayList;
  final Function(BodyCategoryModel) deleteFromActivityOfDayList;
  final BodyCategoryModel bodyCategoryModel;
  final VoidCallback deleteFunction;

  const BodyPartItemBlock({
    super.key,
    required this.profileModel,
    required this.isSelected,
    required this.addToActivityOfDayList,
    required this.deleteFromActivityOfDayList,
    required this.bodyCategoryModel,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    var languageModel = bodyCategoryModel.getLanguageClass(context);
    DateTime dateTime = DateTime(
      0,
      0,
      0,
      bodyCategoryModel.hour!,
      bodyCategoryModel.minute!,
      bodyCategoryModel.second!,
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s36),
      ),
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
                      fontFamily: FontFamily.kPoppinsFont,
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    SizedBox(
                      width: AppHorizontalSize.s90,
                      height: AppVerticalSize.s22,
                      child: RecordedUnitBlock(
                        icon: Icons.timer,
                        mesuaringUnit: '',
                        unitValue: DateFormat('HH:mm:ss').format(dateTime),
                        iconColor: ColorManager.kBlackColor,
                        textColor: ColorManager.kBlackColor,
                      ),
                    ),
                    SizedBox(
                      width: AppHorizontalSize.s90,
                      height: AppVerticalSize.s22,
                      child: RecordedUnitBlock(
                        icon: Icons.directions_run_outlined,
                        mesuaringUnit: S.of(context).exercises,
                        unitValue: languageModel.numberOfExercises!,
                        iconColor: ColorManager.kBlackColor,
                        textColor: ColorManager.kBlackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constrain) {
              return Stack(
                alignment: Get.locale!.languageCode.toString() == 'en'
                    ? Alignment.topRight
                    : Alignment.topLeft,
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
                  Positioned(
                    right: Get.locale!.languageCode.toString() == 'en' ? 0 : null,
                    left: Get.locale!.languageCode.toString() == 'en' ? null : 0,
                    top: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (profileModel.isPremium || profileModel.isClient == false)
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppHorizontalSize.s10,
                              vertical: AppVerticalSize.s5),
                          child: InkWell(
                            onTap: () {
                              if (isSelected) {
                                deleteFromActivityOfDayList(
                                    bodyCategoryModel);
                              } else {
                                addToActivityOfDayList(
                                    bodyCategoryModel);
                              }
                            },
                            child: Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off_outlined,
                              color: isSelected
                                  ? ColorManager.kLimeGreenColor
                                  : ColorManager.kWhiteColor,
                            ),
                          ),
                        )
                            : const SizedBox(),
                        !profileModel.isClient
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppHorizontalSize.s10,
                              vertical: AppVerticalSize.s5),
                          child: InkWell(
                            onTap: deleteFunction,
                            child: Icon(
                              Icons.delete,
                              color: ColorManager.kRed,
                            ),
                          ),
                        )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
