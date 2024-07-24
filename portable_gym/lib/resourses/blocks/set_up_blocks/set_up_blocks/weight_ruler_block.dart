import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../cubits/set_up_cubit/set_up_cubit.dart';


class WeightRulerBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var setCubit = SetUpCubit.get(context);

    return  RulerPicker(
      rulerScaleTextStyle: const TextStyle(color: ColorManager.kBlackColor),
      rulerBackgroundColor: ColorManager.kLightPurpleColor,
      controller: setCubit.WeightController,
      onBuildRulerScaleText: (index, value) {
        return value.toInt().toString();
      },
      ranges: const [
        RulerRange(begin: 0, end: 300, scale: 1),
      ],
      scaleLineStyleList: const [
        ScaleLineStyle(
            color: ColorManager.kBlackColor, width: 1.5, height: 30, scale: 0),
        ScaleLineStyle(
            color: ColorManager.kBlackColor, width: 1, height: 25, scale: 5),
        ScaleLineStyle(
            color: ColorManager.kBlackColor, width: 1, height: 15, scale: -1)
      ],
      onValueChanged: (value) {
        setCubit.getWeight(weight: value.toInt());
      },
      width: MediaQuery.of(context).size.width,
      height: AppVerticalSize.s80,
      rulerMarginTop: AppVerticalSize.s14,
    );



}
}
