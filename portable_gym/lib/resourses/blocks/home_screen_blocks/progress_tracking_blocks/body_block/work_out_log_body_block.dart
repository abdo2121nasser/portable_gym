import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../../generated/l10n.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/font_manager.dart';
import '../../../../managers_files/style_manager.dart';
import '../full_personal_information_block.dart';
import 'package:intl/intl.dart';

class WorkOutLogBodyBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressTrackingCubit, ProgressTrackingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var progCubit = ProgressTrackingCubit.get(context);
        return Column(
          children: [
            FullPersonalInformationBlock(),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){ progCubit.selectDateTime(context);},
                    child: Text(
                      S.of(context).chooseDate,
                      style: getSemiBoldStyle(
                          fontSize: FontSize.s14,
                          color: ColorManager.kLimeGreenColor,
                          fontFamily: FontFamily.kLeagueSpartanFont),
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(progCubit.currentDate),
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.kLimeGreenColor,
                        fontFamily: FontFamily.kLeagueSpartanFont),
                  ),
                ],
              ),
              const Divider(),
              Text(
                S.of(context).activities,
                style: getMediumStyle(
                    fontSize: FontSize.s20,
                    color: ColorManager.kLimeGreenColor,
                    fontFamily: FontFamily.kPoppinsFont),
              )
            ],
          ),
        )

          ],
        );
      },
    );
  }
}
