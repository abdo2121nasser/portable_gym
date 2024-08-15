import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/resource_cubit/resource_cubit.dart';

import '../../resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';



class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResourceCubit(),
      child: BlocConsumer<ResourceCubit, ResourceState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var resCubit=ResourceCubit.get(context);
          return Column(
            children: [
              HorizontalCategoryListBlock(
                  currentLevel: resCubit.currentResource,
                  numberOfLevels: resCubit.getResourceLables(context: context).length,
                  lables: resCubit.getResourceLables(context: context),
                  changeLevel: (index) {
                    resCubit.changeCurrentResource(index: index);
                  }),
              resCubit.resourcesBodies[resCubit.currentResource],
            ],
          );
        },
      ),
    );
  }
}
