import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/floating_action_button_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/food_main_element_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';
import '../../../../../resourses/models/profile_models/profile_model.dart';

class FoodMainElementScreen extends StatelessWidget {
  NutritionCubit nutCubit;
  final ProfileModel profileModel;

  FoodMainElementScreen(
      {super.key, required this.nutCubit, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    final TabBar foodMainElementTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return BlocProvider.value(
      value: nutCubit..getFoodMainElement(),
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {},
        builder: (context, state) {
          // var nutCubit = NutritionCubit.get(context);
          return Scaffold(
            appBar: GeneralAppBarBlock(title: S.of(context).foodMainElement),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state is GetFoodMainElementLoadingState
                    ? const Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ColorManager.kPurpleColor,
                            )),
                      )
                    : Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppHorizontalSize.s22,
                              vertical: AppVerticalSize.s14),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // mainAxisExtent: 140,
                                  crossAxisSpacing: AppHorizontalSize.s22,
                                  childAspectRatio: (3 / 1),
                                  mainAxisSpacing: AppVerticalSize.s14),
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: AppHorizontalSize.s22,
                                        vertical: AppVerticalSize.s55),
                                    backgroundColor: Colors.white,
                                    alignment: Alignment.center,
                                    title: Text(
                                      nutCubit.foodElementModels[index]
                                          .getLanguageClass(context)
                                          .title!,
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      nutCubit.foodElementModels[index]
                                          .getLanguageClass(context)
                                          .description!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: (profileModel.isClient == false)
                                  ? () {
                                      nutCubit.setFoodMainElementAttributes(
                                          model: nutCubit
                                              .foodElementModels[index]);
                                      showAlertFoodMainElementBox(
                                          context: context,
                                          tabBar: foodMainElementTabBar,
                                          tabBarView: nutCubit
                                              .getFoodMainElementTabBarViews(
                                                  nutritionCubit: nutCubit),
                                          buttonFunction: () {
                                            nutCubit.editFoodMainElement(
                                                docId: nutCubit
                                                    .foodElementModels[index]
                                                    .docId);
                                          },
                                          title: S.of(context).foodMainElement,
                                          buttonLable: S.of(context).edit);
                                    }
                                  : null,
                              child: FoodMainElementBlock(
                                title: nutCubit.foodElementModels[index]
                                    .getLanguageClass(context)
                                    .title!,
                                content: nutCubit.foodElementModels[index]
                                    .getLanguageClass(context)
                                    .description!,
                                deleteFunction: (profileModel.isClient == false)
                                    ? () {
                                        showAlertDeleteBox(
                                            context: context,
                                            deleteFunction: () {
                                              nutCubit.deleteFoodMainElement(
                                                  docId: nutCubit
                                                      .foodElementModels[index]
                                                      .docId);
                                            });
                                      }
                                    : null,
                              )),
                          itemCount: nutCubit.foodElementModels.length,
                        ),
                      )
              ],
            ),
            floatingActionButton: (profileModel.isClient == false)
                ? FloatingActionButtonBlock(
                    function: () {
                      nutCubit.clearFoodMainElementAttributes();

                      showAlertFoodMainElementBox(
                          context: context,
                          tabBar: foodMainElementTabBar,
                          tabBarView: nutCubit.getFoodMainElementTabBarViews(
                              nutritionCubit: nutCubit),
                          buttonFunction: nutCubit.addNewFoodMainElement,
                          title: S.of(context).foodMainElement,
                          buttonLable: S.of(context).add);
                    },
                  )
                : null,
          );
        },
      ),
    );
  }
}
