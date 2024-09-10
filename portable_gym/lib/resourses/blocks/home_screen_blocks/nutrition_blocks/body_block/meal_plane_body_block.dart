import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/admin_view_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/user_view_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';


class MealPlaneBodyBlock extends StatelessWidget {
  const MealPlaneBodyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NutritionCubit.get(context),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<NutritionCubit, NutritionState>(
            listener: (context, state) {},
            builder: (context, state) {
              var nutCubit = NutritionCubit.get(context);
              var profCubit = ProfileCubit.get(context);

              return
                  state is GetNutritionUserDocIdLoadingState ||

                      profCubit.profileModel == null
                  ? const Expanded(
                    child: Align(
                alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: ColorManager.kPurpleColor,
                        ),
                      ),
                  )
                  : profCubit.profileModel!.isClient
                      ? const UserViewBlock()
                      : const AdminViewBlock();
            },
          );
        },
      ),
    );
  }
}
