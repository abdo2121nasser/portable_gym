import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/favourite_cubit/favourite_cubit.dart';

import '../../../../cubits/resource_cubit/resource_cubit.dart';
import '../../../managers_files/color_manager.dart';
import '../grid_view_resources_block.dart';



class NutritionBodyBlock extends StatelessWidget {
  const NutritionBodyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ResourceCubit.get(context)..getAllRecipes(),
      child: BlocConsumer<ResourceCubit, ResourceState>(
        listener: (context, state) {},
        builder: (context, state) {
          var resCubit = ResourceCubit.get(context);
          return Expanded(
            child: Column(
              children: [
                state is GetAllRecipesLoadingState||
            state is AddFavouriteRecipeLoadingState||
            state is DeleteFavouriteRecipeLoadingState
                    ? const Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: ColorManager.kPurpleColor,
                      )),
                )
                    :

                GridViewResourcesBlock(recipeModel: resCubit.recipeModels),
              ],
            ),
          );
        },
      ),
    );
  }
}
