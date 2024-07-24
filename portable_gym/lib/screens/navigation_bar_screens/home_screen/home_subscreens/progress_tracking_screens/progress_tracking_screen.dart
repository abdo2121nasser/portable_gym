import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
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
    return BlocProvider(
      create: (context) => ProgressTrackingCubit(),
      child: BlocConsumer<ProgressTrackingCubit, ProgressTrackingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var progCubit = ProgressTrackingCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.kBlackColor,
            appBar: GeneralAppBarBlock(title: S
                .of(context)
                .progressTrack),
            body: Column(
              children: [
                HorizontalCategoryListBlock(
                    currentLevel: progCubit.currentBodyLevel,
                    numberOfLevels: progCubit
                        .getBodyLevelLables(context)
                        .length,
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
      ),
    );
  }
}
