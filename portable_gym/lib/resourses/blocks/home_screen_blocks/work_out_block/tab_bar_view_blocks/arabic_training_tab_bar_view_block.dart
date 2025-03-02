import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:my_coach/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/work_out_block/training_baisic_information_block.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../../../managers_files/color_manager.dart';
import '../../../general_blocks/full_input_block.dart';

class ArabicTrainingTabBarViewBlock extends StatelessWidget {
  final WorkOutCubit workCubit;

  ArabicTrainingTabBarViewBlock({required this.workCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: workCubit,
      child: BlocConsumer<WorkOutCubit, WorkOutState>(
        listener: (context, state) {},
        builder: (context, state) {
         // var workCubit = WorkOutCubit.get(context);
          return Column(
            children: [
              Expanded(
                child: TrainingBaisicInformationBlock(
                    trainingLables: workCubit.trainingArabicLables,
                    trainingControllers: workCubit
                        .getTrainingArabicControllers(),
                    isArabicTabView: true,
                    isPaidValue: workCubit.trainingIsPaid,
                    isPaidSetter: (bool? value) {
                      if (value != null)
                        workCubit.setTrainingIsPaid(value: value);
                    }
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
