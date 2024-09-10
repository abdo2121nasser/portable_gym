import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/managers_files/color_manager.dart';

class ProgressTrackingScreen extends StatelessWidget {
  final ProfileCubit profCubit;

  const ProgressTrackingScreen({super.key, required this.profCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profCubit,
      child: BlocProvider(
        create: (context) => ProgressTrackingCubit(userDocId: profCubit.userDocId),
        child: BlocConsumer<ProgressTrackingCubit, ProgressTrackingState>(
          listener: (context, state) {},
          builder: (context, state) {
            var progCubit = ProgressTrackingCubit.get(context);
            var lables = progCubit
                .getBodyLevelLables(context);
            var currentBody=progCubit.getCurrentBody()[progCubit.currentBodyLevel];
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorManager.kBlackColor,
              appBar: GeneralAppBarBlock(title: S
                  .of(context)
                  .progressTrack),
              // body: Column(
              //   children: [
              //     HorizontalCategoryListBlock(
              //         currentLevel: progCubit.currentBodyLevel,
              //         numberOfLevels: lables.length,
              //         lables: lables,
              //         changeLevel: (index) {
              //           progCubit.changeCurrentBodyIndex(index: index);
              //         }),
              //     SizedBox(
              //       height: AppVerticalSize.s10,
              //     ),
              //    currentBody
              //   ],
              // ),
              body: currentBody,
            );
          },
        ),
      ),
    );
  }
}
