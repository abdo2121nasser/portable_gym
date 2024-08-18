import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../generated/l10n.dart';

class FileBoxBlock extends StatelessWidget {
  final VoidCallback suffixIconFunction;
  final bool hasSuffixIcon;
  final bool hasConstraints;
  final bool isDownloadingState;
  final Icon? suffixIcon;

  const FileBoxBlock(
      {super.key,
      required this.suffixIconFunction,
      required this.hasSuffixIcon,
      this.hasConstraints = false,
        this.isDownloadingState=false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppVerticalSize.s8),
      margin: EdgeInsets.symmetric(
          vertical: AppVerticalSize.s5, ),
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s12),
      ),
      constraints: hasConstraints
          ? BoxConstraints(
              maxHeight: AppVerticalSize.s60,
              maxWidth: MediaQuery.of(context).size.width * 0.48,
            )
          : null,
      child: Row(
        children: [
          Icon(Icons.insert_drive_file, color: ColorManager.kBlue),
          SizedBox(width: AppHorizontalSize.s8),
          Expanded(
            child: Text(S.of(context).file, overflow: TextOverflow.ellipsis),
          ),
          !hasSuffixIcon
              ? const SizedBox()
              : IconButton(
                  icon:
                      suffixIcon ?? Icon(Icons.close, color: ColorManager.kRed),
                  onPressed: () {
                    suffixIconFunction();
                  },
                ),
        ],
      ),
    );
  }
}
