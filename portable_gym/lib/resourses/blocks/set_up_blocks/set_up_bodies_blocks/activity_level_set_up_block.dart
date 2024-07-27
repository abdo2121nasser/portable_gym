import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';

import '../../../managers_files/values_manager.dart';

import '../set_up_blocks/levels_block.dart';

class ActivityLevelSetUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetUpCubit, SetUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        var setUpCubit = SetUpCubit.get(context);
        return SizedBox(
          height: AppVerticalSize.s253,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  setUpCubit.changeCurrentActivityLevel(index: index);
                },
                child: LevelsBlock(
                    title:
                        setUpCubit.getPhysicalActivity(context: context)[index],
                    isChoosed: setUpCubit.currentActivityLevel == index),
              ),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppVerticalSize.s22,
                  ),
              itemCount: 3),
        );
      },
    );
  }
}
