part of 'work_out_cubit.dart';

@immutable
abstract class WorkOutState {}

class WorkOutInitial extends WorkOutState {}
class SetTrainingPeriod extends WorkOutState {}
class SetBodyCategoryTotalTime extends WorkOutState {}
class UploadFileToDriveState extends WorkOutState {}

class PickVideoLoadingState extends WorkOutState {}
class PickVideoSuccessState extends WorkOutState {}
class PickVideoErrorState extends WorkOutState {}

class AddNewTrainingLoadingState extends WorkOutState {}
class AddNewTrainingSuccessState extends WorkOutState {}
class AddNewTrainingErrorState extends WorkOutState {}
