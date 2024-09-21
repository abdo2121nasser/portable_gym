import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import '../../cubits/profile_cubit/profile_cubit.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit()..getUserDocId(),
      child: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          var favCubit = FavouriteCubit.get(context);
          return Column(
            children: [
              HorizontalCategoryListBlock(
                  currentLevel: favCubit.currentCategory,
                  numberOfLevels:
                      favCubit.getFavouriteCategories(context).length,
                  lables: favCubit.getFavouriteCategories(context),
                  changeLevel: (index) {
                    favCubit.changeCurrentCategory(index: index);
                  }),
              state is GetUserDocIdLoadingState ||
              state is GetFavouriteTrainingLoadingState ||
              state is GetFavouriteRecipesLoadingState||
              state is DeleteFavouriteTrainingLoadingState||
              state is DeleteFavouriteRecipeLoadingState

                  ? const Expanded(child: Center(child: CircularProgressIndicator(
                color: ColorManager.kPurpleColor,
              )))
                  : favCubit.categories[favCubit.currentCategory]
            ],
          );
        },
      ),
    );
  }
}
