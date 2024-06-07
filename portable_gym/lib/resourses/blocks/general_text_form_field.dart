import 'package:flutter/material.dart';

import '../managers_files/color_manager.dart';


class GeneralTextFormField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          fillColor: ColorManager.kWhiteColor,
          filled: true
      ),
    );
  }
}
