import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/level_element_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

class LevelListBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOutCubit, WorkOutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var workCubit = WorkOutCubit.get(context);
        return SizedBox(
          height: AppVerticalSize.s55,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){
                        workCubit.changeCurrentLevel(newLevel: index);
                      },
                      child: LevelElementBlock(
                          lable: workCubit.getLevelLabels(
                              index: index, context: context),
                      color: workCubit.currentLevel==index?ColorManager.kLimeGreenColor: ColorManager.kWhiteColor,),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: AppHorizontalSize.s5,
                        ),
                    itemCount: 3),
              ),

            ],
          ),
        );
      },
    );
  }
}
