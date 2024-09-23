import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:my_coach/cubits/resource_cubit/resource_cubit.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';


class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit()..getUserDocId(),
      child: BlocProvider(
        create: (context) => ResourceCubit(),
        child: BlocConsumer<ResourceCubit, ResourceState>(
          listener: (context, state) {},
          builder: (context, state) {
            var resCubit = ResourceCubit.get(context);
            return Column(
              children: [
                HorizontalCategoryListBlock(
                    currentLevel: resCubit.currentResource,
                    numberOfLevels: resCubit.resourcesBodies.length,
                    lables: resCubit.getResourceLables(context: context),
                    changeLevel: (index) {
                      resCubit.changeCurrentResource(index: index);
                    }),
                SizedBox(
                  height: AppVerticalSize.s5,
                ),
                resCubit.resourcesBodies[resCubit.currentResource],
              ],
            );
          },
        ),
      ),
    );
  }
}
