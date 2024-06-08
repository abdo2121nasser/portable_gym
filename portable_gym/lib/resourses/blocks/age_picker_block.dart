import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

import '../managers_files/values_manager.dart';



class AgePickerBlock extends StatelessWidget {
  const AgePickerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalPicker(
      minValue: 12,
      maxValue: 50,
      divisions:38,
      height: AppVerticalSize.s120,
      //suffix: " th",

      //showCursor: false,
      backgroundColor: Colors.black,
      //   cursorColor: Colors.yellow,
      onChanged: (value) {
        // Handle the selected value
        //print("Selected value: $value");
      },
    );
  }
}
