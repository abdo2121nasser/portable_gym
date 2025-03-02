import 'package:flutter/material.dart';
import 'package:my_coach/cubits/setting_cubit/setting_cubit.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/alert_box_manager.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/string_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/setting_models/question_model.dart';
import '../../general_blocks/check_box_block.dart';
import '../../general_blocks/general_button_block.dart';

class QuestionWithChoicesBlock extends StatelessWidget {

  final QuestionModel model;
  final String collection;
  final Function(QuestionModel)? addChoiceFunction;
  final Function(bool, int)? checkBoxFunction;
  final bool isClientView;
  const QuestionWithChoicesBlock(
      {super.key,
      required this.model,
        required this.collection,
      this.addChoiceFunction,
        this.checkBoxFunction,
      required this.isClientView});
  @override
  Widget build(BuildContext context) {
    var settCubit = SettingCubit.get(context);
    final TabBar questionsTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
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
                      padding: EdgeInsets.only(right: AppHorizontalSize.s5),
                      child: InkWell(
                        onTap: () {
                          settCubit.setControllersWithModel(model: model);
                          showAlertQuestionBox(
                              context: context,
                              tabBar: questionsTabBar,
                              tabBarView: settCubit.getQuestionsTabBarViews(
                                  isQuestion: true),
                              firstButtonFunction: () {
                                settCubit.editQuestion(model: model,collection:collection);
                              },
                              title: S.of(context).questions,
                              firstButtonLable: S.of(context).edit,
                              secondButtonLable: S.of(context).delete,
                              secondButtonFunction: () {
                                settCubit.deleteQuestion(model: model,collection:collection);
                              },
                              isSingleButton: false);
                        },
                        child: Icon(
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
        Padding(
          padding: EdgeInsets.only(left: AppHorizontalSize.s5),
          child: Text(
            model.getLanguageClass(context).question,
            style: getMediumStyle(
                fontSize: FontSize.s14,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s14),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 140,
              crossAxisSpacing: AppHorizontalSize.s14,
              // childAspectRatio: (2.5 / 0.46),
              mainAxisSpacing: AppVerticalSize.s12,
              mainAxisExtent: AppVerticalSize.s30
          ),
          itemBuilder: (context, index) => !isClientView &&
                  index == model.getLanguageClass(context).answers.length
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      addChoiceFunction!(model);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AppHorizontalSize.s2,
                      ),

                      decoration: BoxDecoration(
                          color: ColorManager.kPurpleColor,
                          borderRadius:
                              BorderRadius.circular(AppRadiusSize.s8)),
                      child:  Icon(
                        Icons.add,
                        size: AppVerticalSize.s26,
                        color: ColorManager.kWhiteColor,
                      ),
                    ),
                  ),
                )
              : CheckBoxBlock(
                  value: model.getLanguageClass(context).answers[index].value,
                  checkBoxFunction: (value) {
                    checkBoxFunction!(value,index);
                  },
                  lable: model.getLanguageClass(context).answers[index].text,
                  borderColor: ColorManager.kWhiteColor,
                  textStyle: getLightStyle(
                    textOverflow: true,
                      fontSize: FontSize.s16,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kLeagueSpartanFont),
                  editChoiceFunction: () {
                    settCubit.setControllersWithModel(
                        model: model, index: index);
                    showAlertQuestionBox(
                      context: context,
                      tabBar: questionsTabBar,
                      tabBarView:
                          settCubit.getQuestionsTabBarViews(isQuestion: false),
                      firstButtonFunction: () {
                        settCubit.editAnswer(model: model, index: index,collection: collection);
                      },
                      title: S.of(context).questions,
                      firstButtonLable: S.of(context).edit,
                      secondButtonLable: S.of(context).delete,
                      secondButtonFunction: () {
                        settCubit.deleteAnswer(model: model, index: index,collection: collection);
                      },
                      isSingleButton: false,
                    );
                  },
                  isSpecialCheckBox: !isClientView,
                ),
          itemCount: isClientView
              ? model.getLanguageClass(context).answers.length
              : model.getLanguageClass(context).answers.length + 1,
        )
      ],
    );
  }
}
