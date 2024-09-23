import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:my_coach/cubits/work_out_cubit/work_out_cubit.dart';

import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../general_blocks/full_input_block.dart';

class EnglishBodyCategoryTabBarViewBlock extends StatelessWidget {
  final WorkOutCubit workCubit;
  final bool isDailyBodyCategory;
  const EnglishBodyCategoryTabBarViewBlock(
      {super.key, required this.workCubit, this.isDailyBodyCategory = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: workCubit,
      child: BlocConsumer<WorkOutCubit, WorkOutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var lables = workCubit.getBodyCategoryEnglishLables(hasFileDownloadField: isDailyBodyCategory);
          var controllers = workCubit.getEnglishBodyCategoryControllers(hasFileDownloadField: isDailyBodyCategory);
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => FullInputBlock(
                    lable: lables[index],
                    color: ColorManager.kBlackColor,
                    controller: controllers[index],
                    multiLine: true,
                    enableBorder: true,
                    onlyInteger: index == 1 || index == 2 ? true : false,
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppVerticalSize.s5,
                  ),
              itemCount: controllers.length);
        },
      ),
    );
  }
}
