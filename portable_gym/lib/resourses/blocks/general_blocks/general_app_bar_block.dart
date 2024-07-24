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
  final bool centerTitle;
  final bool haveReturnArrow;

  GeneralAppBarBlock({required this.title,
    this.actions=const [],
    this.function,
    this.centerTitle=false,
    this.haveReturnArrow=true,
    this.titleColor=ColorManager.kPurpleColor,
    this.backgroundColor= ColorManager.kBlackColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backgroundColor,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      title: InkWell(
        onTap:haveReturnArrow? () {
          if(function==null) {
            Get.back();
          } else
            {
              function!();
            }
        } :null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           haveReturnArrow? const Icon(
              Icons.arrow_left,
              color: ColorManager.kLimeGreenColor,
            ):const SizedBox(),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}