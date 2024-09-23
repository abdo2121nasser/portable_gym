import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../../cubits/set_up_cubit/set_up_cubit.dart';




class HeightRulerBlock extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var setCubit = SetUpCubit.get(context);

    return VerticalWeightSlider(
      height: MediaQuery.of(context).size.height*0.23,
      controller: setCubit.heightController,
      decoration:  PointerDecoration(
        width: AppHorizontalSize.s150,
        height: AppVerticalSize.s5,
        largeColor: const Color(0xFF898989),
        mediumColor: const Color(0xFFC5C5C5),
        smallColor: const Color(0xFFF0F0F0),
        gap:  AppVerticalSize.s30,
      ),
      onChanged: (double value) {
        setCubit.getHeight(height: value.toInt());
      },
      indicator: Container(
        height:  AppVerticalSize.s5,
        width: AppHorizontalSize.s178,
        alignment: Alignment.centerLeft,
        color: Colors.red[300],
      ),
    );
  }
}
