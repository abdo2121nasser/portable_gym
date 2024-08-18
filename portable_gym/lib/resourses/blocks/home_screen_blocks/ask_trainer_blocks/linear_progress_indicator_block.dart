import 'package:flutter/material.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/values_manager.dart';



class LinearProgressIndicatorBlock extends StatelessWidget {
final bool isLoading;

const LinearProgressIndicatorBlock({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return    isLoading
        ? Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s8,
          vertical: AppVerticalSize.s5),
      child: const LinearProgressIndicator(
        color: ColorManager.kPurpleColor,
        backgroundColor: ColorManager.kLightPurpleColor,
      ),
    )
        : const SizedBox();
  }
}
