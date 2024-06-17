import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../cubits/set_up_cubit/set_up_cubit.dart';



class HeightRulerBlock extends StatelessWidget {

//todo fix it

  @override
  Widget build(BuildContext context) {
    var setCubit = SetUpCubit.get(context);

    return VerticalWeightSlider(
      height: AppVerticalSize.s120,

      controller: setCubit.heightController,
      decoration: const PointerDecoration(
        width: 130.0,
        height: 3.0,
        largeColor: Color(0xFF898989),
        mediumColor: Color(0xFFC5C5C5),
        smallColor: Color(0xFFF0F0F0),
        gap: 30.0,
      ),
      onChanged: (double value) {
        setCubit.getHeight(height: value.toInt());
      },
      indicator: Container(
        height: 3.0,
        width: 150.0,
        alignment: Alignment.centerLeft,
        color: Colors.red[300],
      ),
    );
  }
}
