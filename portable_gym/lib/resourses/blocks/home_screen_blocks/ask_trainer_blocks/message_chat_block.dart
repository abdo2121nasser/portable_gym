import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';

class MessageChatBlock extends StatelessWidget {
  final String message;
  final bool isSenderMessage;

  const MessageChatBlock({
    super.key,
    required this.message,
    required this.isSenderMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          !isSenderMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s14),
          constraints: BoxConstraints(
            minHeight: AppVerticalSize.s65,
            maxWidth: MediaQuery.of(context).size.width*0.48,
          ),
          decoration: BoxDecoration(
            color: !isSenderMessage
                ? ColorManager.kLightPurpleColor
                : ColorManager.kPurpleColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(AppRadiusSize.s14),
              bottomLeft: Radius.circular(AppRadiusSize.s14),
              topRight: !isSenderMessage
                  ? Radius.circular(AppRadiusSize.s14)
                  : const Radius.circular(0),
              topLeft: isSenderMessage
                  ? Radius.circular(AppRadiusSize.s14)
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
        ),
      ],
    );
  }
}
