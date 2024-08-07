import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/home_screen_blocks/nutrition_blocks/list_questions_with_choices_block.dart';



class MealPlanQuestionScreen extends StatelessWidget {
  const MealPlanQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: GeneralAppBarBlock(title: S.of(context).questions,),
      body:  const Column(
        children: [
          ListOfQuestionsWithChoicesBlock(
            titles: ['Dietary Preferences'],
            questions: ['What are your dietary preferences?'],
            choicesText: ['Vegetarian'],
            isClientView: false,
          )

        ],
      ),
    );
  }
}
