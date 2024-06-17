import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import '../set_up_blocks/age_picker_block.dart';

class AgeSetUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SetUpCubit, SetUpState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var setCubit = SetUpCubit.get(context);
        return SizedBox(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      setCubit.age.toString(),
                      style: getBoldStyle(
                          fontSize: FontSize.s64,
                          color: ColorManager.kWhiteColor,
                          fontFamily: FontFamily.kPoppinsFont),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.arrow_drop_up_rounded,
                      color: ColorManager.kLimeGreenColor,
                      size: AppVerticalSize.s120,
                    ),
                  ],
                ),
                const AgePickerBlock(),
              ],
            ));
      },
    );
  }
}
