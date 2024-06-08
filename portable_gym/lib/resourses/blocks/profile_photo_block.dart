import 'package:flutter/material.dart';

import '../managers_files/color_manager.dart';
import '../managers_files/image_manager.dart';
import '../managers_files/values_manager.dart';

class ProfilePhotoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // width:100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: Image.asset(ImageManager.kSmileManImage).image)),
        ),
        Positioned(
          bottom: AppVerticalSize.s2,
          left: MediaQuery.of(context).size.width * 0.56,
          child: Container(
            padding: EdgeInsets.all(AppVerticalSize.s5),
            decoration: BoxDecoration(
                color: ColorManager.kLimeGreenColor, shape: BoxShape.circle),
            child: Image.asset(ImageManager.kPenIconImage),
          ),
        )
      ],
    );
  }
}
