import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_coach/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:my_coach/cubits/resource_cubit/resource_cubit.dart';
import 'package:my_coach/cubits/resource_cubit/resource_cubit.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/square_element _block.dart';
import '../../home_screen_blocks/nutrition_blocks/recipe_grid_square_block.dart';
import '../grid_view_resources_block.dart';

class WorkOutBodyBlock extends StatelessWidget {
  const WorkOutBodyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ResourceCubit.get(context)..getAllTrainings(),
      child: BlocConsumer<ResourceCubit, ResourceState>(
        listener: (context, state) {},
        builder: (context, state) {
          var resCubit = ResourceCubit.get(context);
          return Expanded(
            child: Column(
              children: [
                state is GetAllTrainingsLoadingState ||
                        state is AddFavouriteTrainingLoadingState ||
                        state is DeleteFavouriteTrainingLoadingState
                    ? const Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ColorManager.kPurpleColor,
                            )),
                      )
                    : GridViewResourcesBlock(
                        trainingModel: resCubit.trainingModels),
              ],
            ),
          );
        },
      ),
    );
  }
}
