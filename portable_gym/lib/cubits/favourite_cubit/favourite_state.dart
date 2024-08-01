part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}
class ChangeCurrentCategory extends FavouriteState {}

class GetUserDocIdLoadingState extends FavouriteState {}
class GetUserDocIdSuccessState extends FavouriteState {}
class GetUserDocIdErrorState extends FavouriteState {}

class AddFavouriteTrainingLoadingState extends FavouriteState {}
class AddFavouriteTrainingSuccessState extends FavouriteState {}
class AddFavouriteTrainingErrorState extends FavouriteState {}

class DeleteFavouriteTrainingLoadingState extends FavouriteState {}
class DeleteFavouriteTrainingSuccessState extends FavouriteState {}
class DeleteFavouriteTrainingErrorState extends FavouriteState {}

class GetFavouriteTrainingLoadingState extends FavouriteState {}
class GetFavouriteTrainingSuccessState extends FavouriteState {}
class GetFavouriteTrainingErrorState extends FavouriteState {}

class AddFavouriteRecipeLoadingState extends FavouriteState {}
class AddFavouriteRecipeSuccessState extends FavouriteState {}
class AddFavouriteRecipeErrorState extends FavouriteState {}

class DeleteFavouriteRecipeLoadingState extends FavouriteState {}
class DeleteFavouriteRecipeSuccessState extends FavouriteState {}
class DeleteFavouriteRecipeErrorState extends FavouriteState {}

class GetFavouriteRecipesLoadingState extends FavouriteState {}
class GetFavouriteRecipesSuccessState extends FavouriteState {}
class GetFavouriteRecipesErrorState extends FavouriteState {}