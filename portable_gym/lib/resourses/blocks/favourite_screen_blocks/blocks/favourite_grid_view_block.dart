import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/models/favourite_models/favourite_training_model.dart';
import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';
import 'package:portable_gym/resourses/models/work_out_models/training_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/recipe_details_screen.dart';

import '../../../../generated/l10n.dart';
import '../../../../screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/favourite_models/favourite_recipe_model.dart';
import '../../general_blocks/square_element _block.dart';

import 'package:intl/intl.dart';

class FavouriteGridViewBlock extends StatelessWidget {
  final List<FavouriteTrainingModel>? favouriteTrainingModels;
  final List<FavouriteRecipeModel>? favouriteRecipeModels;
  final Function(String) deleteFavouriteFunction;
  const FavouriteGridViewBlock(
      {super.key,
      this.favouriteTrainingModels,
      this.favouriteRecipeModels,
      required this.deleteFavouriteFunction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: (1 / .8),
            mainAxisSpacing: 15),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                if (favouriteTrainingModels != null) {
                  Get.to(() => ExerciseScreen(
                        trainingModel: TrainingModel(
                            english: favouriteTrainingModels![index].english,
                            arabic: favouriteTrainingModels![index].arabic,
                            videoLink:
                                favouriteTrainingModels![index].videoLink,
                            startPeriod:
                                favouriteTrainingModels![index].startPeriod,
                            endPeriod:
                                favouriteTrainingModels![index].endPeriod,
                            docId: null,
                            bodyCategory: null,
                            isPaid: null,
                            level: null,
                            priority: null),
                      ));
                } else {
                  Get.to(RecipeDetailsScreen(
                      recipeModel: RecipeModel(
                          english: favouriteRecipeModels![index].english,
                          arabic: favouriteRecipeModels![index].arabic,
                          docId: favouriteRecipeModels![index].recipeDocId,
                          imageLink: favouriteRecipeModels![index].imageLink,
                          isSnacks: false,
                          isDinner: false,
                          isBreakfast: false,
                          isLunch: false)));
                }
              },
              child: SquareElementBlock(
                canBeDeleted: true,
                title: favouriteRecipeModels?[index]
                        .getLanguageClass(context)
                        .name ??
                    favouriteTrainingModels![index]
                        .getLanguageClass(context)
                        .name!,
                subValue: favouriteTrainingModels != null
                    ?
                '${S.of(context).rest} ${S.of(context).from} ${favouriteTrainingModels![index].startPeriod} '
                    '${S.of(context).to} ${favouriteTrainingModels![index].endPeriod!}'

                  : favouriteRecipeModels![index]
                        .getLanguageClass(context)
                        .calories!,
                isFavouriteItem: true,
                isTraining: favouriteTrainingModels!=null,
                imageLink: favouriteTrainingModels?[index].videoLink ??
                    favouriteRecipeModels![index].imageLink,
                isVideo: favouriteTrainingModels != null,
                deleteFavouriteFunction: () {
                  deleteFavouriteFunction(
                      favouriteTrainingModels?[index].trainingDocId ??
                          favouriteRecipeModels![index].recipeDocId);
                },
              ));
        },
        itemCount:
            favouriteTrainingModels?.length ?? favouriteRecipeModels!.length,
      ),
    );
  }
}
