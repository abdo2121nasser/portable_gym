import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';

import '../blocks/favourite_grid_view_block.dart';


class RecipeCategoryBodyBlock extends StatelessWidget {
  const RecipeCategoryBodyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: FavouriteCubit.get(context),
      child: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          var favCubit = FavouriteCubit.get(context);
          return FavouriteGridViewBlock(
            deleteFavouriteFunction: (doc) {
              favCubit.deleteFavouriteRecipe(recipeDocId: doc);
            },
            favouriteRecipeModels: favCubit.favouriteRecipeModels,);
        },
      ),
    );
  }
}
