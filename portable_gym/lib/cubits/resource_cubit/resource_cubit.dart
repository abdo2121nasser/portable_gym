import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/resources_blocks/bodies_blocks/nutrition_body_block.dart';
import '../../resourses/blocks/resources_blocks/bodies_blocks/work_out_body_block.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/nutrition_models/recipe_model.dart';
import '../../resourses/models/work_out_models/training_model.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  ResourceCubit() : super(ResourceInitial());
  static ResourceCubit get(context) => BlocProvider.of(context);

  List<TrainingModel> trainingModels = [];
  List<RecipeModel> recipeModels = [];

  int currentResource = 0;
  List<Widget> resourcesBodies = [
    const WorkOutBodyBlock(),
    const NutritionBodyBlock()
  ];

  changeCurrentResource({required int index}) {
    currentResource = index;
    emit(ChangeCurrentResourceState());
  }

  getResourceLables({required context}) {
    return [
      S.of(context).workOut,
      S.of(context).nutrition,
    ];
  }

  getAllTrainings() {
    if(trainingModels.isNotEmpty) return;
    emit(GetAllTrainingsLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings)
    .where(StringManager.trainingIsPaid,isEqualTo: false)
    ;
    data.get().then((value) {
      value.docs.forEach((element) {
        trainingModels.add(
            TrainingModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetAllTrainingsSuccessState());
    }).catchError((error) {
      emit(GetAllTrainingsErrorState());
      debugPrint(error);
    });
  }

  getAllRecipes() {
    if(recipeModels.isNotEmpty) return;
    emit(GetAllRecipesLoadingState());
    var data =
        FirebaseFirestore.instance.collection(StringManager.collectionRecipes);
    data.get().then((value) {
      value.docs.forEach((element) {
        recipeModels
            .add(RecipeModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetAllRecipesSuccessState());
    }).catchError((error) {
      emit(GetAllRecipesErrorState());
      debugPrint(error);
    });
  }
}
