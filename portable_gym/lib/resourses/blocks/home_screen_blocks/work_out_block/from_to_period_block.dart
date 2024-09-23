import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:my_coach/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/values_manager.dart';


class FromToPeriodBlock extends StatelessWidget {
   final WorkOutCubit workCubit;

  const FromToPeriodBlock({super.key, required this.workCubit});

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: workCubit,
  child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            child: FullInputBlock(
              enableBorder: true,

              color: ColorManager.kBlackColor,
              controller:workCubit.trainingStartPeriodController, lable: S.of(context).from,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            child: FullInputBlock(
              enableBorder: true,

              color: ColorManager.kBlackColor,
              controller:workCubit.trainingEndPeriodController, lable: S.of(context).to,
            ),
          ),

        ],
      ),
    ),
);
  }
}

