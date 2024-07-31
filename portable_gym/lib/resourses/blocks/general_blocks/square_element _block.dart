import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_video_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/recorded_unit_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/exercise_video_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../models/nutrition_models/recipe_model.dart';

class SquareElementBlock extends StatelessWidget {
//final RecipeModel recipeModel;
  final String imageLink;
  final String title;
  final String subValue;

  final VoidCallback? deleteFunction;
  final VoidCallback? deleteFavouriteFunction;
  final bool isViewOnly;
  final bool isFavouriteItem;
  final bool isVideo;
  final bool isTraining;

  const SquareElementBlock({
    super.key,
    // required  this.recipeModel,
    required this.title,
    required this.subValue,
    required this.imageLink,
    this.isViewOnly = false,
    this.isFavouriteItem = false,
    this.deleteFunction,
    this.deleteFavouriteFunction,
    this.isVideo = false,
    this.isTraining=false,
  });

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
                  child:isVideo?SizedBox(
                      width: constrain.maxWidth,
                      height: constrain.maxHeight*0.6,
                      child: GeneralVideoBlock(videoLink: imageLink,)): Image.network(
                    imageLink,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return SizedBox(
                          height: AppVerticalSize.s80,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppHorizontalSize.s30),
                              child: CircularProgressIndicator(
                                color: ColorManager.kBlue,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    height: constrain.maxHeight * 0.57,
                    width: constrain.maxWidth,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: constrain.maxHeight * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppHorizontalSize.s5),
                        child: SizedBox(
                          height: constrain.maxHeight * 0.2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
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
                          // SizedBox(
                          //     width: constrain.maxWidth * 0.45,
                          //     height: constrain.maxHeight * 0.15,
                          //     child: RecordedUnitBlock(
                          //       icon: Icons.timer,
                          //       mesuaringUnit: 'minute',
                          //       unitValue: '45',
                          //     )),
                          SizedBox(
                              width: constrain.maxWidth ,
                              height: constrain.maxHeight * 0.15,
                              child: RecordedUnitBlock(
                                icon: isTraining?Icons.timer: Icons.local_fire_department_outlined,
                                mesuaringUnit:isTraining? '':S.of(context).kCal,
                                unitValue: subValue,
                              )),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap:(){
                            if(isFavouriteItem) {
                              deleteFavouriteFunction!();
                            }
                          },
                          child: Icon(
                            isFavouriteItem
                                ? Icons.star_rounded
                                : Icons.star_border,
                            color: isFavouriteItem
                                ? ColorManager.kLimeGreenColor
                                : ColorManager.kBlackColor,
                          ),
                        ),
                        isViewOnly
                            ? const SizedBox()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppHorizontalSize.s5),
                                child: InkWell(
                                  onTap: () {
                                    deleteFunction!();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: ColorManager.kRed,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    // SizedBox(
                    //   height: constrain.maxHeight * 0.28,
                    // ),
                    // Container(
                    //     decoration: const BoxDecoration(
                    //         color: ColorManager.kPurpleColor,
                    //         shape: BoxShape.circle),
                    //     child: const Icon(
                    //       Icons.play_arrow_rounded,
                    //       color: ColorManager.kWhiteColor,
                    //     ))
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
