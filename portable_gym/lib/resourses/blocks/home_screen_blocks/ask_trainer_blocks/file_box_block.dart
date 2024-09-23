import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';
import '../../../../generated/l10n.dart';

class FileBoxBlock extends StatelessWidget {
  final VoidCallback suffixIconFunction;
  final bool hasSuffixIcon;
  final bool hasConstraints;
  final bool isDownloadingState;
  final bool isChatFile;
  final Future<bool>? isDownloaded;
  final Icon? suffixIcon;
  final String fileName;

  const FileBoxBlock({
    super.key,
    required this.suffixIconFunction,
    required this.hasSuffixIcon,
    required this.fileName,
    this.hasConstraints = false,
    this.isDownloadingState = false,
    this.suffixIcon,
    this.isChatFile=true,
    this.isDownloaded
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppVerticalSize.s8),
      margin: EdgeInsets.symmetric(
        vertical: AppVerticalSize.s5,
      ),
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
            child: Text(fileName, overflow: TextOverflow.ellipsis),
          ),

          !hasSuffixIcon
              ? const SizedBox()
              :
          isChatFile?
          FutureBuilder<bool>(
            future: isDownloaded,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loader while waiting
              } else if (snapshot.hasData && snapshot.data==true) {
                return IconButton(
                  icon: Icon(Icons.open_with, color: ColorManager.kBlackColor),
                  onPressed:(){
                    suffixIconFunction();
                  },
                );
              } else {
                return  SizedBox(height: AppVerticalSize.s44,);
              }
            },
          ):IconButton(
            icon: suffixIcon ?? Icon(Icons.close, color: ColorManager.kRed),
            onPressed:(){
              suffixIconFunction();
            },
          ),
        ],
      ),
    );
  }
}
