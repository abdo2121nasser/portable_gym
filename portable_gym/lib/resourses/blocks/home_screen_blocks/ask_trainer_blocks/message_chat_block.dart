import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import 'file_box_block.dart';

class MessageChatBlock extends StatelessWidget {
  final String message;
  final String? fileLink;
  final bool isSenderMessage;
  final bool isDownloadingState;

  const MessageChatBlock({
    super.key,
    required this.message,
    this.fileLink,
    required this.isSenderMessage,
    this.isDownloadingState=false,
  });

  @override
  Widget build(BuildContext context) {
    var askCubit = AskTrainerCubit.get(context);
    return Row(
      mainAxisAlignment:
          !isSenderMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: !isSenderMessage
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            if (fileLink!.isNotEmpty)
              FileBoxBlock(
                hasSuffixIcon: true,
                suffixIcon:
                const Icon(Icons.download, color: ColorManager.kBlackColor),
                suffixIconFunction: () {
                  askCubit.downloadFileToDownloads(url: fileLink!,context: context);
                },
                hasConstraints: true,
              ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppHorizontalSize.s22,
                  vertical: AppVerticalSize.s14),
              constraints: BoxConstraints(
                minHeight: AppVerticalSize.s44,
                maxWidth: MediaQuery.of(context).size.width * 0.48,
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
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
