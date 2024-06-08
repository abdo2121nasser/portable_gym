import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

//RulerPickerController? _rulerPickerController;


class WeightRulerBlock extends StatelessWidget {
  const WeightRulerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: RulerPicker(
        rulerScaleTextStyle:TextStyle(color: ColorManager.kBlackColor) ,
        rulerBackgroundColor: ColorManager.kPurpleColor,
       // controller: _rulerPickerController!,
        onBuildRulerScaleText: (index, value) {
          return value.toInt().toString();
        },
        ranges: const [
          RulerRange(begin: 0, end: 250, scale: 1),
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
          // setState(() {
          //   currentValue = value;
          // });
        },
        width: MediaQuery.of(context).size.width,
        height: AppVerticalSize.s80,
        rulerMarginTop: AppVerticalSize.s14,

      ),
    );
  }
}
