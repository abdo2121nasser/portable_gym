part of 'ask_trainer_cubit.dart';

@immutable
abstract class AskTrainerState {}

class AskTrainerInitial extends AskTrainerState {}

class GetAllAdminsLoadingState extends AskTrainerState {}
class GetAllAdminsSuccessState extends AskTrainerState {}
class GetAllAdminsErrorState extends AskTrainerState {}

class GetAllClientsLoadingState extends AskTrainerState {}
class GetAllClientsSuccessState extends AskTrainerState {}
class GetAllClientsErrorState extends AskTrainerState {}

class SendMessageLoadingState extends AskTrainerState {}
class SendMessageSuccessState extends AskTrainerState {}
class SendMessageErrorState extends AskTrainerState {}
