import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/list_questions_with_choices_block.dart';

class MealPlanCreationScreen extends StatelessWidget {
  const MealPlanCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).mealPlan,
      ),
      body: const Column(
        children: [
          ListOfQuestionsWithChoicesBlock(
            titles: ['Dietary Preferences'],
            questions: ['What are your dietary preferences?'],
            choicesText: ['Vegetarian'],
            choicesValues: [true],
            isClientView: true,
          )

        ],
      ),
    );
  }
}
