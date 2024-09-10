import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class OptionBlock extends StatelessWidget {
  final String lable;
  final String? subValue;
  final String? image;
  final IconData icon;
  final Switch? mySwitch;

  const OptionBlock(
      {super.key,
      required this.lable,
      this.subValue,
      this.image,
      required this.icon,
      this.mySwitch});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                        width: AppHorizontalSize.s50,
                        height: AppVerticalSize.s44,
                        padding: EdgeInsets.all(AppVerticalSize.s5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.kPurpleColor),
                        child: image != null
                            ? Image.network(image!,fit: BoxFit.contain,

                        )
                            : Icon(
                                icon,
                                color: ColorManager.kWhiteColor,
                              )),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppHorizontalSize.s10),
                        child: Text(
                          lable,
                          style: getRegularStyle(
                              fontSize: FontSize.s20,
                              color: ColorManager.kWhiteColor,
                              fontFamily: FontFamily.kLeagueSpartanFont),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (subValue != null && subValue != '0') const Spacer(),
              subValue != null && subValue != '0'
                  ? Container(
                      padding: EdgeInsets.all(
                        AppVerticalSize.s5,
                      ),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.kLightPurpleColor),
                      child: Text(subValue!),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        mySwitch == null
            ? const Icon(
                Icons.arrow_right,
                color: ColorManager.kLimeGreenColor,
              )
            : mySwitch!,
      ],
    );
  }
}
