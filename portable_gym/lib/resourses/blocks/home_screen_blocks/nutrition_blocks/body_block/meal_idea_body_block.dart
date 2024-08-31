import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';

import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';

import '../../../../../cubits/profile_cubit/profile_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../recipe_grid_square_block.dart';
import '../../work_out_block/horizontal_category_list_block.dart';

class MealIdeaBodyBlock extends StatelessWidget {
  const MealIdeaBodyBlock({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => FavouriteCubit()..getUserDocId(),
  child: BlocProvider.value(
      value: NutritionCubit.get(context)..getFilteredRecipes(),
      child: BlocConsumer<NutritionCubit, NutritionState>(
            listener: (context, state) {},
            builder: (context, state) {
              var nutCubit = NutritionCubit.get(context);
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: AppVerticalSize.s14),
                      child: HorizontalCategoryListBlock(
                          currentLevel: nutCubit.currentMealType,
                          numberOfLevels:
                              nutCubit.getMealTypeLables(context: context).length,
                          lables: nutCubit.getMealTypeLables(context: context),
                          changeLevel: (index) {
                            nutCubit.changeCurrentMealType(index: index);
                          }),
                    ),
                    state is GetFilteredRecipesLoadingState ||
                        state is FavouriteGetUserDocIdLoadingState
                        ? const Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: ColorManager.kPurpleColor,
                          )),
                    )
                        :
                    RecipeGridSquareBlock(
                      profileModel: ProfileCubit.get(context).profileModel!,
                      recipeModels: nutCubit.recipeModels,
                      editFunction: (docId) {
                        nutCubit.editRecipe(docId: docId);
                      },
                      setAttributes: (RecipeModel model){
                        nutCubit.setRecipeAttributes(model: model);
                      },
                      deleteFunction: (docId){
                        nutCubit.deleteRecipe(docId: docId);
                      },
                      tabBarView: nutCubit.getRecipeTabBarViews(nutritionCubit: nutCubit),
                    ),
                  ],
                ),
              );
            },
          ),
    ),
);
  }
}
