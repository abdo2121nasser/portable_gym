import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/progress_tracking_blocks/full_personal_information_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';

class ProgressTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressTrackingCubit, ProgressTrackingState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var progCubit = ProgressTrackingCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.kBlackColor,
          appBar: AppBar(
            backgroundColor: ColorManager.kBlackColor,
            leadingWidth: AppHorizontalSize.s220,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_left,
                    color: ColorManager.kLimeGreenColor,
                  ),
                  Expanded(
                    child: Text(
                      S
                          .of(context)
                          .progressTrack,
                      style: getBoldStyle(
                          fontSize: FontSize.s20,
                          color: ColorManager.kPurpleColor,
                          fontFamily: FontFamily.kPoppinsFont),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              HorizontalCategoryListBlock(
                  currentLevel: progCubit.currentBodyLevel,
                  numberOfLevels: progCubit.getBodyLevelLables(context).length,
                  lables: progCubit.getBodyLevelLables(context),
                  changeLevel: (index) {
                    progCubit.changeCurrentBodyIndex(index: index);
                  }),
              SizedBox(
                height: AppVerticalSize.s10,
              ),
              progCubit.bodies[progCubit.currentBodyLevel],
            ],
          ),
        );
      },
    );
  }
}
