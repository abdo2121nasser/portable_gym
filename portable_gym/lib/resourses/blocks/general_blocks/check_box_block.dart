import 'package:flutter/material.dart';



class CheckBoxBlock extends StatelessWidget {
   final bool value;
   final Function(bool?) function;
   CheckBoxBlock({required this.value,required this.function});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: CircleBorder(),
      value: value,
      onChanged: function,
    );
  }
}
