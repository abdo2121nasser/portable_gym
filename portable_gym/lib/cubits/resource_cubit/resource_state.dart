part of 'resource_cubit.dart';

@immutable
abstract class ResourceState {}

class ResourceInitial extends ResourceState {}
class ChangeCurrentResourceState extends ResourceState {}

class GetAllTrainingsLoadingState extends ResourceState {}
class GetAllTrainingsSuccessState extends ResourceState {}
class GetAllTrainingsErrorState extends ResourceState {}

class GetAllRecipesLoadingState extends ResourceState {}
class GetAllRecipesSuccessState extends ResourceState {}
class GetAllRecipesErrorState extends ResourceState {}
