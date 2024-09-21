import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/square_element%20_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/recipe_details_screen.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';

class RecipeGridSquareBlock extends StatelessWidget {
  final List<RecipeModel> recipeModels;
  final Function(RecipeModel) setAttributes;
  final Function(String) editFunction;
  final Function(String) deleteFunction;
  final TabBarView tabBarView;
  final bool hasFavouriteIcon;
  final ProfileModel profileModel;


  const RecipeGridSquareBlock(
      {super.key,
        required this.profileModel,
      required this.recipeModels,
      this.hasFavouriteIcon = true,
      required this.editFunction,
      required this.deleteFunction,
      required this.setAttributes,
      required this.tabBarView});

  @override
  Widget build(BuildContext context) {
    final TabBar recipeTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return hasFavouriteIcon?
      BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var favCubit = FavouriteCubit.get(context);
        return Expanded(
          child: state is AddFavouriteRecipeLoadingState ||
                  state is DeleteFavouriteRecipeLoadingState
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: ColorManager.kPurpleColor,
                  ),
                )
              :
          GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppHorizontalSize.s22,
                      vertical: AppVerticalSize.s14),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: (1 / .8),
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) => FutureBuilder(
                      future: hasFavouriteIcon
                          ? favCubit.isRecipeIsFavourite(
                              recipeDocId: recipeModels[index].docId)
                          : Future(() => false),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        } else {
                          return InkWell(
                              onTap: () {
                                Get.to(RecipeDetailsScreen(
                                    recipeModel: recipeModels[index]));
                              },
                              onLongPress:( profileModel.isClient==false)? () {
                                setAttributes(recipeModels[index]);
                                showAlertRecipeBox(
                                    context: context,
                                    tabBar: recipeTabBar,
                                    tabBarView: tabBarView,
                                    buttonFunction: () {
                                      editFunction(recipeModels[index].docId);
                                    },
                                    title: S.of(context).recipe,
                                    buttonLable: S.of(context).editRecipe);
                              }:null,
                              child: SquareElementBlock(
                                title: recipeModels[index]
                                    .getLanguageClass(context)
                                    .name!,
                                subValue: recipeModels[index]
                                    .getLanguageClass(context)
                                    .calories!,
                                imageLink: recipeModels[index].imageLink,
                                deleteFunction: () {
                                  showAlertDeleteBox(context: context,deleteFunction: (){
                                    deleteFunction(recipeModels[index].docId);
                                  });

                                },
                                isFavouriteItem: snapshot.data!,
                                addFavouriteFunction: () {
                                  favCubit.addFavouriteRecipe(
                                      recipeModel: recipeModels[index]);
                                },
                                deleteFavouriteFunction: () {
                                  favCubit.deleteFavouriteRecipe(
                                      recipeDocId: recipeModels[index].docId);
                                },
                                hasFavouriteIcon: hasFavouriteIcon,
                                canBeDeleted: !(profileModel.isClient==false),

                              ));
                        }
                      }),
                  itemCount: recipeModels.length,
                ),
        );
      },
    ):
    GridView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s22,
          vertical: AppVerticalSize.s14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: (1 / .8),
          mainAxisSpacing: 15),
      itemBuilder: (context, index) =>InkWell(
          onTap: () {
            Get.to(RecipeDetailsScreen(
                recipeModel: recipeModels[index]));
          },
          onLongPress:( profileModel.isClient==false)? () {
            setAttributes(recipeModels[index]);
            showAlertRecipeBox(
                context: context,
                tabBar: recipeTabBar,
                tabBarView: tabBarView,
                buttonFunction: () {
                  editFunction(recipeModels[index].docId);
                },
                title: S.of(context).recipe,
                buttonLable: S.of(context).editRecipe);
          }:null,
          child: SquareElementBlock(
            title: recipeModels[index]
                .getLanguageClass(context)
                .name!,
            subValue: recipeModels[index]
                .getLanguageClass(context)
                .calories!,
            imageLink: recipeModels[index].imageLink,
            deleteFunction: () {

              showAlertDeleteBox(context: context,deleteFunction: (){
                deleteFunction(recipeModels[index].docId);
              });
            },
            hasFavouriteIcon: false,
          )),
      itemCount: recipeModels.length,
    )
    ;
  }
}
