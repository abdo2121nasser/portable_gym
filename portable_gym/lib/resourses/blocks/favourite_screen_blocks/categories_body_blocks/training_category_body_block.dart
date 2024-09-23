import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:my_coach/cubits/favourite_cubit/favourite_cubit.dart';

import '../blocks/favourite_grid_view_block.dart';


class TrainingCategoryBodyBlock extends StatelessWidget {
  const TrainingCategoryBodyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: FavouriteCubit.get(context),
      child: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          FavouriteCubit favCubit = FavouriteCubit.get(context);
          return   FavouriteGridViewBlock(
            favouriteTrainingModels: favCubit.favouriteTrainingModels,
          deleteFavouriteFunction:(docId){
              favCubit.deleteFavouriteTrainings(trainingDocId: docId);
          },
          );
        },
      ),
    );
  }
}
