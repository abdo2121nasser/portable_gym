import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/check_box_block.dart';
import '../../general_blocks/general_button_block.dart';

class QuestionWithChoicesBlock extends StatelessWidget {
  final String title;
  final String question;
  final List<String> choicesText;
  final List<bool>? choicesValues;
  final bool isClientView;
  const QuestionWithChoicesBlock(
      {super.key,
      required this.title,
      required this.question,
      required this.choicesText,
      this.choicesValues,
      required this.isClientView});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s10),
          child: Row(
            children: [
              isClientView
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppHorizontalSize.s5),
                      child: InkWell(
                        onTap: () {},
                        child:  Icon(
                          Icons.open_in_new_rounded,
                          color: ColorManager.kWhiteColor,
                          size: FontSize.s24,
                        ),
                      ),
                    ),
              Text(
                title,
                style: getMediumStyle(
                    fontSize: FontSize.s24,
                    color: ColorManager.kLimeGreenColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),
              const Spacer(),
              IconButton(
                onPressed: (){},
                icon:Icon( Icons.delete,
                color: ColorManager.kRed,
                ))
            ],
          ),
        ),
        Row(
          children: [
            isClientView
                ? const SizedBox()
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppHorizontalSize.s5),
                    child: InkWell(
                      onTap: () {},
                      child:  Icon(
                        Icons.open_in_new_rounded,
                        color: ColorManager.kWhiteColor,
                        size: FontSize.s14,
                      ),
                    ),
                  ),
            Text(
              question,
              style: getMediumStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s14),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 140,
              crossAxisSpacing: 0,
              childAspectRatio: (2.5 / 0.38),
              mainAxisSpacing: 15),
          itemBuilder: (context, index) =>
              !isClientView && index == choicesText.length
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child:InkWell(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.only(left: AppHorizontalSize.s5),
                          decoration: BoxDecoration(
                            color: ColorManager.kPurpleColor,
                            borderRadius: BorderRadius.circular(AppRadiusSize.s8)
                          ),
                          child: const Icon(
                            Icons.add,
                            color: ColorManager.kWhiteColor,
                          ),
                        ),
                      ),
                    )
                  : CheckBoxBlock(
                      value: choicesValues?[index],
                      checkBoxFunction: (f) {},
                      lable: choicesText[index],
                      borderColor: ColorManager.kWhiteColor,
                      textStyle: getLightStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.kWhiteColor,
                          fontFamily: FontFamily.kLeagueSpartanFont),
                      isSqecialCheckBox: !isClientView,
                    ),
          itemCount: isClientView ? choicesText.length : choicesText.length + 1,
        )
      ],
    );
  }
}
