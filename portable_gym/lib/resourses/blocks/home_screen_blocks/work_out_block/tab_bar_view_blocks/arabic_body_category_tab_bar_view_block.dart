import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/work_out_cubit/work_out_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../general_blocks/full_input_block.dart';

class ArabicBodyCategoryTabBarViewBlock extends StatelessWidget {
  final WorkOutCubit workCubit;
  final bool isDailyBodyCategory;

  const ArabicBodyCategoryTabBarViewBlock(
      {super.key, required this.workCubit, this.isDailyBodyCategory = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: workCubit,
      child: BlocConsumer<WorkOutCubit, WorkOutState>(
        listener: (context, state) {},
        builder: (context, state) {
          //   var workCubit = WorkOutCubit.get(context);
          var lables = workCubit.getBodyCategoryArabicLables(hasFileDownloadField: isDailyBodyCategory);
          var controllers = workCubit.getArabicBodyCategoryControllers();
          return ListView.separated(
              // padding: EdgeInsets.only(bottom: AppVerticalSize.s10),
              shrinkWrap: true,
              itemBuilder: (context, index) => FullInputBlock(
                    lable: lables[index],
                    color: ColorManager.kBlackColor,
                    controller: controllers[index],
                    enableBorder: true,
                    isArabicTabView: true,
                    onlyInteger: index == 1 || index == 2 ? true : false,
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppVerticalSize.s5,
                  ),
              itemCount: lables.length);
        },
      ),
    );
  }
}
