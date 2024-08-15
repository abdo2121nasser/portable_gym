import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';

class MessageChatBlock extends StatelessWidget {
  final String message;
  final bool isAdminMessage;

  const MessageChatBlock({
    super.key,
    required this.message,
    required this.isAdminMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: AppHorizontalSize.s30,
        minHeight:  AppHorizontalSize.s30,
        maxHeight:   AppHorizontalSize.s150,
        maxWidth:   AppHorizontalSize.s150,
      ),
      decoration: BoxDecoration(
        color: isAdminMessage ? ColorManager.kLimeGreenColor : ColorManager.kLightPurpleColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppRadiusSize.s22),
          bottomLeft: Radius.circular(AppRadiusSize.s22),
          topRight: isAdminMessage
              ? Radius.circular(AppRadiusSize.s22)
              : const Radius.circular(0),
          topLeft: !isAdminMessage
              ? Radius.circular(AppRadiusSize.s22)
              : const Radius.circular(0),
        ),
      ),
      child: Text(
        message,
        style: getMediumStyle(
          fontSize: FontSize.s16,
          color: ColorManager.kWhiteColor,
          fontFamily: FontFamily.kPoppinsFont,
        ),
      ),
    );
  }
}
