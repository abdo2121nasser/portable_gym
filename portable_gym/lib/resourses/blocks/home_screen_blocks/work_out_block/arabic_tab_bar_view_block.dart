import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/training_baisic_information_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../general_blocks/full_input_block.dart';

class ArabicTabBarViewBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var workCubit = WorkOutCubit.get(context);
        return Column(
          children: [
            Expanded(
                child: TrainingBaisicInformationBlock(
                    trainingLables: workCubit.trainingArabicLables,
                    trainingControllers: workCubit.getTrainingEnglishControllers(),
                  isLableAtEnd: true,
                )
            ),
          ],
        );
      },
    );
  }
}
