part of 'ask_trainer_cubit.dart';

@immutable
abstract class AskTrainerState {}

class AskTrainerInitial extends AskTrainerState {}

class GetAllAdminsLoadingState extends AskTrainerState {}
class GetAllAdminsSuccessState extends AskTrainerState {}
class GetAllAdminsErrorState extends AskTrainerState {}
