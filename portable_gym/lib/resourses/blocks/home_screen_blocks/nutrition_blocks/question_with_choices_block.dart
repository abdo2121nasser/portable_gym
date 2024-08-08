import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/setting_models/meal_plan_question_model.dart';
import '../../general_blocks/check_box_block.dart';
import '../../general_blocks/general_button_block.dart';

class QuestionWithChoicesBlock extends StatelessWidget {
  // final String title;
  // final String question;
  // final List<Answer> answers;
  final MealPlanQuestionModel model;
  final Function(MealPlanQuestionModel)? addChoiceFunction;
  final bool isClientView;
  const QuestionWithChoicesBlock(
      {super.key,
      required this.model,
        this.addChoiceFunction,
      required this.isClientView});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                model.getLanguageClass(context).title,
                style: getMediumStyle(
                    fontSize: FontSize.s24,
                    color: ColorManager.kLimeGreenColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),

            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,

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
              model.getLanguageClass(context).question,
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
              !isClientView && index == model.getLanguageClass(context).answers.length
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child:InkWell(
                        onTap: (){
                          addChoiceFunction!(model);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s2,),
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
                      value: model.getLanguageClass(context).answers[index].value,
                      checkBoxFunction: (f) {},
                      lable: model.getLanguageClass(context).answers[index].text,
                      borderColor: ColorManager.kWhiteColor,
                      textStyle: getLightStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.kWhiteColor,
                          fontFamily: FontFamily.kLeagueSpartanFont),
                      isSqecialCheckBox: !isClientView,
                    ),
          itemCount: isClientView ? model.getLanguageClass(context).answers.length : model.getLanguageClass(context).answers.length + 1,
        )
      ],
    );
  }
}
