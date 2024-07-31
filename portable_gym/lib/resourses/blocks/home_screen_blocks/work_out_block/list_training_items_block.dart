import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/round_item_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import '../../../../cubits/favourite_cubit/favourite_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';
import '../../../managers_files/alert_box_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/work_out_models/training_model.dart';

class ListTrainingItemsBlock extends StatelessWidget {
  final List<TrainingModel> trainingModel;
  final String bodyCategory;

  ListTrainingItemsBlock({
    super.key,
    required this.trainingModel,
    required this.bodyCategory,
  });

  @override
  Widget build(BuildContext context) {
    final TabBar trainingTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord),
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );

    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<WorkOutCubit, WorkOutState>(
          listener: (context, state) {},
          builder: (context, state) {
            var workCubit = WorkOutCubit.get(context);
            var favCubit = FavouriteCubit.get(context);

            return
            Expanded(
              child: state is AddFavouriteTrainingLoadingState?  const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: ColorManager.kPurpleColor,
                ),
              ): ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppHorizontalSize.s20,
                  vertical: AppVerticalSize.s10,
                ),
                itemBuilder: (context, index) {
                  return
                  FutureBuilder<bool>(
                    future: favCubit.isTrainingIsFavourite(
                      trainingDocId: trainingModel[index].docId!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }  else {
                        return InkWell(
                          onTap: () {
                            Get.to(ExerciseScreen(
                              trainingModel: trainingModel[index],
                            ));
                          },
                          onLongPress: () {
                            workCubit.clearTrainingAttributes();
                            workCubit.setTrainingAttributes(
                              model: trainingModel[index],
                            );

                            showAlertTrainingBox(
                              context: context,
                              workOutCubit: workCubit,
                              title: S.of(context).editTraining,
                              buttonLable: S.of(context).uploadTraining,
                              tabBar: trainingTabBar,
                              tabBarView: workCubit.getTrainingTabBarView(
                                workOutCubit: workCubit,
                              ),
                              trainingPeriod: workCubit.trainingPeriod,
                              buttonFunction: () {
                                workCubit.editTraining(
                                  docId: trainingModel[index].docId!,
                                  bodyCategory: bodyCategory,
                                );
                              },
                            );
                          },
                          child: RoundItemBlock(
                            trainingModel: trainingModel[index],
                            deleteFunction: () {
                              workCubit.deleteTraining(
                                docId: trainingModel[index].docId!,
                                bodyCategory: bodyCategory,
                              );
                            },
                            addToFavouriteFunction: () async {
                              favCubit.addFavouritTraining(
                                trainingModel: await workCubit.getTrainingUsingDocId(
                                  trainingDocId: trainingModel[index].docId!,
                                ),
                              );
                            },
                            isTrainingFavourite: snapshot.data!,
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: AppVerticalSize.s18,
                ),
                itemCount: trainingModel.length,
              ),
            );
          },
        );
      },
    );
  }
}
