import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var favCubit = FavouriteCubit.get(context);
        return Column(
          children: [
            HorizontalCategoryListBlock(
                currentLevel: favCubit.currentCategory,
                numberOfLevels: favCubit.getFavouriteCategory(context).length,
                lables: favCubit.getFavouriteCategory(context),
                changeLevel: (index) {
                  favCubit.changeCurrentCategory(index: index);
                }),
            favCubit.categories[favCubit.currentCategory]
          ],
        );
      },
    );
  }
}
