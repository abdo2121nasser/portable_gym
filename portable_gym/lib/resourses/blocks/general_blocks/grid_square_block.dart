import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/square_element%20_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/recipe_details_screen.dart';

import '../../../generated/l10n.dart';

class GridSquareBlock extends StatelessWidget {
  final List<RecipeModel> recipeModel;
  final Function(RecipeModel) setAttributes;
  final Function(String) editFunction;
  final Function(String) deleteFunction;
  final TabBarView tabBarView;

  GridSquareBlock(
      {required this.recipeModel,
      required this.editFunction,
        required this.deleteFunction,
        required this.setAttributes,
      required this.tabBarView});

  @override
  Widget build(BuildContext context) {
    final TabBar recipeTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: (1 / .8),
            mainAxisSpacing: 15),
        itemBuilder: (context, index) => InkWell(
          onTap: (){
            Get.to(RecipeDetailsScreen(recipeModel: recipeModel[index]));
          },
            onLongPress: () {
              setAttributes(recipeModel[index]);
              showAlertRecipeBox(
                  context: context,
                  tabBar: recipeTabBar,
                  tabBarView: tabBarView,
                  buttonFunction: () {
                    editFunction(recipeModel[index].docId);
                  },
                  title: S.of(context).recipe,
                  buttonLable: S.of(context).editRecipe);
            },

            child: SquareElementBlock(
              recipeModel: recipeModel[index],
              deleteFunction: (docId){
                deleteFunction(docId);
              },
            )),
        itemCount: recipeModel.length,
      ),
    );
  }
}
