part of 'resource_cubit.dart';

@immutable
abstract class ResourceState {}

class ResourceInitial extends ResourceState {}
class ChangeCurrentResourceState extends ResourceState {}
