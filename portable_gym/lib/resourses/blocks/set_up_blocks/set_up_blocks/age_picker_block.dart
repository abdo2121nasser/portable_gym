import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

import '../../../../cubits/set_up_cubit/set_up_cubit.dart';
import '../../../managers_files/values_manager.dart';




class AgePickerBlock extends StatelessWidget {
  const AgePickerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    var setCubit= SetUpCubit.get(context);

    return HorizontalPicker(
      minValue: 12,
      maxValue: 50,
      divisions:38,
      height: AppVerticalSize.s120,

      backgroundColor: Colors.black,
      onChanged: (value) {
        setCubit.getAge(age: value.toInt());
      },
    );
  }
}
