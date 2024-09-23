import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/set_up_cubit/set_up_cubit.dart';
import 'package:my_coach/cubits/set_up_cubit/set_up_cubit.dart';


import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../set_up_blocks/gender_block.dart';
import '../set_up_blocks/height_ruler_block.dart';

class HeightSetUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetUpCubit, SetUpState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var setCubit = SetUpCubit.get(context);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              setCubit.height.toString(),
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

        Container(
              width: MediaQuery.of(context).size.width,
              //   height: AppVerticalSize.s253,
              color: ColorManager.kLightPurpleColor,
              padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s20, vertical: AppVerticalSize.s5),
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          HeightRulerBlock(),
          SizedBox(
            height: AppVerticalSize.s14,
          ),
        ],
              ),
            ),
      ],
    );
  },
);
  }
}
