import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/work_out_cubit/work_out_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../general_blocks/full_input_block.dart';


class ArabicBodyCategoryTabBarViewBlock extends StatelessWidget {
  final WorkOutCubit workCubit;

  ArabicBodyCategoryTabBarViewBlock({required this.workCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: workCubit,

      child: BlocConsumer<WorkOutCubit, WorkOutState>(
        listener: (context, state) {},
        builder: (context, state) {
       //   var workCubit = WorkOutCubit.get(context);
          return ListView.separated(
            // padding: EdgeInsets.only(bottom: AppVerticalSize.s10),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  FullInputBlock(
                    lable: workCubit.bodyCategoryArabicLables[index],
                    color: ColorManager.kBlackColor,
                    controller: workCubit.getArabicBodyCategoryControllers(
                        index: index),
                    enableBorder: true,
                    isArabicTabView: true,
                    onlyInteger: index == 1 || index == 2 ? true : false,),
              separatorBuilder: (context, index) =>
                  SizedBox(
                    height: AppVerticalSize.s5,
                  ),
              itemCount: workCubit.bodyCategoryArabicLables.length);
        },
      ),
    );
  }
}
