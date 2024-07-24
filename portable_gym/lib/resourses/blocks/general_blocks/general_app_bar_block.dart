import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';


class GeneralAppBarBlock extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Color backgroundColor;
  final Color titleColor;
  final VoidCallback? function;

  GeneralAppBarBlock({required this.title,
    this.actions=const [],
    this.function,
    this.titleColor=ColorManager.kPurpleColor,
    this.backgroundColor= ColorManager.kBlackColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backgroundColor,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () {
          if(function==null) {
            Get.back();
          } else
            {
              function!();
            }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.arrow_left,
              color: ColorManager.kLimeGreenColor,
            ),
            Flexible(
              child: Text(
               title,
                style: getBoldStyle(
                    fontSize: FontSize.s20,
                    color:titleColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}