import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/favourite_screen_blocks/categories_body_blocks/recipe_category_body_block.dart';
import '../../resourses/blocks/favourite_screen_blocks/categories_body_blocks/training_category_body_block.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/favourite_models/favourite_training_model.dart';
import '../../resourses/models/work_out_models/training_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {

  FavouriteCubit({required this.email}) : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);
 late final String userDocId;
      final String email;
  int currentCategory=0;
 List<Widget> categories=[const TrainingCategoryBodyBlock(),const RecipeCategoryBodyBlock()];
 List<FavouriteTrainingModel> favouriteTrainingModels=[];
     getUserDocId() async {
       emit(GetUserDocIdLoadingState());
       await FirebaseFirestore.instance
           .collection(StringManager.collectionUserProfiles).where(StringManager.userEmail,isEqualTo:email ).get()
           .then((value) {
             userDocId=value.docs[0].id;
         emit(GetUserDocIdSuccessState());

       }).catchError((error){
         emit(GetUserDocIdErrorState());
         debugPrint(error);

       });
     }
  getFavouriteCategory(context){
    return [
      S.of(context).exercises,
      S.of(context).recipe,
    ];
  }
  changeCurrentCategory({required int index})
  {
    currentCategory=index;
    emit(ChangeCurrentCategory());
  }

 Future<bool> isTrainingIsFavourite({required String trainingDocId}) async {
  return  await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).doc(userDocId).collection(StringManager.collectionUserFavouriteTraining)
        .where( StringManager.trainingDocId, isEqualTo: trainingDocId).get()
        .then((value) {
        return  value.docs.isNotEmpty;
    });
  }

  addFavouritTraining({required TrainingModel trainingModel}) async {
    emit(AddFavouriteTrainingLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).doc(userDocId).collection(StringManager.collectionUserFavouriteTraining).add(
      {
        StringManager.trainingEnglishName: trainingModel.english!.name,
        StringManager.trainingEnglishNumberOfReputation:
        trainingModel.english!.numberOfReputation,
        StringManager.trainingEnglishNumberOfRounds:
        trainingModel.english!.numberOfRounds,
        StringManager.trainingEnglishInstruction:
        trainingModel.english!.instructions,
        StringManager.trainingArabicName: trainingModel.arabic!.name,
        StringManager.trainingArabicNumberOfReputation:
        trainingModel.arabic!.numberOfReputation,
        StringManager.trainingArabicNumberOfRounds:
        trainingModel.arabic!.numberOfRounds,
        StringManager.trainingArabicInstruction:
        trainingModel.arabic!.instructions,
        StringManager.trainingVideoLink: trainingModel.videoLink,
        StringManager.trainingHourPeriod:   trainingModel.hour,
        StringManager.trainingMinutePeriod: trainingModel.minute,
        StringManager.trainingSecondPeriod: trainingModel.second,
        StringManager.trainingDocId:trainingModel.docId,
      }
    ).then((value) async {
      emit(AddFavouriteTrainingSuccessState());

    }).catchError((error){
      debugPrint(error);
      emit(AddFavouriteTrainingErrorState());

    });
  }

  getFavouriteTrainings() async {
       favouriteTrainingModels.clear();
       emit(GetFavouriteTrainingLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(userDocId)
        .collection(StringManager.collectionUserFavouriteTraining)
        .get().then((value) {
          value.docs.forEach((element) {
            favouriteTrainingModels.add(FavouriteTrainingModel.fromJson(json: element.data(), docId: element.id));
          });
          emit(GetFavouriteTrainingSuccessState());

    }).catchError((error){
      emit(GetFavouriteTrainingErrorState());
      debugPrint(error);
    });
  }



}
