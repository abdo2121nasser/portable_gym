import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/progress_tracking_blocks/vertical_measurement_block.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';

class VerticalInformationBlock extends StatelessWidget {
  final ProfileModel profileModel;
  const VerticalInformationBlock({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppHorizontalSize.s178,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      profileModel.fullName,
                      style: getBoldStyle(
                          fontSize: FontSize.s22,
                          color: ColorManager.kWhiteColor,
                          fontFamily: FontFamily.kPoppinsFont),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: AppHorizontalSize.s10,
                  ),
                  Image.asset(
                    ImageManager.kMaleImage,
                    width: AppHorizontalSize.s22,
                    color: ColorManager.kLimeGreenColor,
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  '${S.of(context).age}: ',
                  style: getSemiBoldStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kLeagueSpartanFont),
                ),
                Text(
                 profileModel.age.toString(),
                  style: getLightStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kLeagueSpartanFont),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            VerticalMeasurementBlock(
              value: profileModel.weight.toString(),
              measurement: S.of(context).weight,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            VerticalMeasurementBlock(
              value: profileModel.height.toString(),
              measurement: S.of(context).height,
            )
          ],
        )
      ],
    );
  }
}
