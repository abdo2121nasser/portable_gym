part of 'progress_tracking_cubit.dart';

@immutable
abstract class ProgressTrackingState {}

class ProgressTrackingInitial extends ProgressTrackingState {}
class ChangeCurrentBodyIndex extends ProgressTrackingState {}
class SelectDateTime extends ProgressTrackingState {}

class AddActivityOfDayLoadingState extends ProgressTrackingState {}
class AddActivityOfDaySuccessState extends ProgressTrackingState {}
class AddActivityOfDayErrorState extends ProgressTrackingState {}
