import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/element_category_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

class HorizontalCategoryListBlock extends StatelessWidget {
  final int currentLevel;
  final int numberOfLevels;
  final List<String> lables;
  final Function(int index) changeLevel;

  HorizontalCategoryListBlock({required this.currentLevel,required this.numberOfLevels,required this.lables,required this.changeLevel});

  @override
  Widget build(BuildContext context) {
        return SizedBox(
          height: AppVerticalSize.s55,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap:(){
                  changeLevel(index);
                },
                child: ElementCategoryBlock(
                    lable: lables[index],
                color: currentLevel==index?ColorManager.kLimeGreenColor: ColorManager.kWhiteColor,),
              ),
              separatorBuilder: (context, index) => SizedBox(
                    width: AppHorizontalSize.s5,
                  ),
              itemCount:numberOfLevels),
        );
  }
}
