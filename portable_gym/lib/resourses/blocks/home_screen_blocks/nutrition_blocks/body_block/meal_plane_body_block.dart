import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/admin_view_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/has_no_meal_plan_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/user_view_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/meal_plan_creation_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../managers_files/alert_box_manager.dart';
import '../../../../managers_files/font_manager.dart';
import '../../../../managers_files/style_manager.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../general_blocks/daily_activity_block.dart';
import '../../work_out_block/horizontal_category_list_block.dart';
import '../meals_types_list_block.dart';

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

              return state is GetUserDocIdLoadingState ||
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
