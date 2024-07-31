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
