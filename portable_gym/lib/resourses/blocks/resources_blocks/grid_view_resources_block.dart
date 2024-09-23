import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/work_out_block/exercise_detail_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/models/nutrition_models/recipe_model.dart';
import 'package:my_coach/resourses/models/work_out_models/training_model.dart';
import 'package:my_coach/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/recipe_details_screen.dart';
import 'package:my_coach/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';

import '../../../cubits/favourite_cubit/favourite_cubit.dart';
import '../../../generated/l10n.dart';
import '../../managers_files/values_manager.dart';
import '../general_blocks/square_element _block.dart';
import 'package:intl/intl.dart';

class GridViewResourcesBlock extends StatelessWidget {
  final List<TrainingModel>? trainingModel;
  final List<RecipeModel>? recipeModel;

  const GridViewResourcesBlock(
      {super.key, this.trainingModel, this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isTrainingModel = trainingModel != null;
        var favCubit = FavouriteCubit.get(context);
        return Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: AppHorizontalSize.s22,
                vertical: AppVerticalSize.s14),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: (1 / .8),
                mainAxisSpacing: 15),
            itemBuilder: (context, index) {
              var model;
              if (isTrainingModel) {
                model = trainingModel![index];
              } else {
                model = recipeModel![index];
              }
              return FutureBuilder(
                  future: isTrainingModel
                      ? favCubit.isTrainingIsFavourite(
                          trainingDocId: model.docId!,
                        )
                      : favCubit.isRecipeIsFavourite(
                          recipeDocId: model.docId!,
                        ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasData == false) {
                      return const SizedBox();
                    } else {
                      return InkWell(
                          onTap: () {
                            if (isTrainingModel) {
                              Get.to(ExerciseScreen(trainingModel: model));
                            } else {
                              Get.to(RecipeDetailsScreen(recipeModel: model));
                            }
                          },
                          child: SquareElementBlock(
                            title: model.getLanguageClass(context).name,
                            subValue: isTrainingModel
                                ?
                            '${S.of(context).rest} ${S.of(context).from} ${trainingModel![index].startPeriod} '
                                '${S.of(context).to} ${trainingModel![index].endPeriod!}'
                                : model.getLanguageClass(context).calories,
                            imageLink: isTrainingModel
                                ? model.videoLink!
                                : model.imageLink,
                            canBeDeleted: true,
                            // isVideo: isTrainingModel,
                            hasFavouriteIcon: true,
                            isFavouriteItem: snapshot.data!,
                            addFavouriteFunction: () {
                              if (isTrainingModel) {
                                favCubit.addFavouritTraining(
                                    trainingModel: model);
                              } else {
                                favCubit.addFavouriteRecipe(recipeModel: model);
                              }
                            },
                            deleteFavouriteFunction: () {
                              if (isTrainingModel) {
                                favCubit.deleteFavouriteTrainings(
                                    trainingDocId: model.docId);
                              } else {
                                favCubit.deleteFavouriteRecipe(
                                    recipeDocId: model.docId);
                              }
                            },
                            isTraining: isTrainingModel,
                          ));
                    }
                  });
            },
            itemCount:
                isTrainingModel ? trainingModel!.length : recipeModel!.length,
          ),
        );
      },
    );
  }
}
