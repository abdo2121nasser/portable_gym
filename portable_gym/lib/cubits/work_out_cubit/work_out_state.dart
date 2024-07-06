part of 'work_out_cubit.dart';

@immutable
abstract class WorkOutState {}

class WorkOutInitial extends WorkOutState {}
class ChangeCurrentLevelState extends WorkOutState {}
class SetTrainingPeriod extends WorkOutState {}
class SetTrainingIsPaid extends WorkOutState {}
class SetBodyCategoryTotalTime extends WorkOutState {}
class SetBodyCategoryControllersState extends WorkOutState {}
class ClearBodyCategoryControllersState extends WorkOutState {}
class ClearTrainingControllersState extends WorkOutState {}
class SetTrainingControllersState extends WorkOutState {}
class UploadFileToDriveState extends WorkOutState {}

class PickVideoLoadingState extends WorkOutState {}
class PickVideoSuccessState extends WorkOutState {}
class PickVideoErrorState extends WorkOutState {}

class AddNewTrainingLoadingState extends WorkOutState {}
class AddNewTrainingSuccessState extends WorkOutState {}
class AddNewTrainingErrorState extends WorkOutState {}

class EditTrainingLoadingState extends WorkOutState {}
class EditTrainingSuccessState extends WorkOutState {}
class EditTrainingErrorState extends WorkOutState {}

class DeleteTrainingLoadingState extends WorkOutState {}
class DeleteTrainingSuccessState extends WorkOutState {}
class DeleteTrainingErrorState extends WorkOutState {}

class AddNewBodyCategoryLoadingState extends WorkOutState {}
class AddNewBodyCategorySuccessState extends WorkOutState {}
class AddNewBodyCategoryErrorState extends WorkOutState {}

class EditBodyCategoryLoadingState extends WorkOutState {}
class EditBodyCategorySuccessState extends WorkOutState {}
class EditBodyCategoryErrorState extends WorkOutState {}

class deleteBodyCategoryLoadingState extends WorkOutState {}
class deleteBodyCategorySuccessState extends WorkOutState {}
class deleteBodyCategoryErrorState extends WorkOutState {}

class GetBodyCategoryLoadingState extends WorkOutState {}
class GetBodyCategorySuccessState extends WorkOutState {}
class GetBodyCategoryErrorState extends WorkOutState {}

class GetDailyBodyCategoryLoadingState extends WorkOutState {}
class GetDailyBodyCategorySuccessState extends WorkOutState {}
class GetDailyBodyCategoryErrorState extends WorkOutState {}

class GetTrainingLoadingState extends WorkOutState {}
class GetTrainingSuccessState extends WorkOutState {}
class GetTrainingErrorState extends WorkOutState {}

