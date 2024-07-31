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

class GetFavouriteTrainingLoadingState extends FavouriteState {}
class GetFavouriteTrainingSuccessState extends FavouriteState {}
class GetFavouriteTrainingErrorState extends FavouriteState {}
