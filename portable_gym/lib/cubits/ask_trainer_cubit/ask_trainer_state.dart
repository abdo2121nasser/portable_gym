part of 'ask_trainer_cubit.dart';

@immutable
abstract class AskTrainerState {}

class AskTrainerInitial extends AskTrainerState {}
class RemoveFileFromSendingState extends AskTrainerState {}

class GetAllAdminsLoadingState extends AskTrainerState {}
class GetAllAdminsSuccessState extends AskTrainerState {}
class GetAllAdminsErrorState extends AskTrainerState {}

class GetAllClientsLoadingState extends AskTrainerState {}
class GetAllClientsSuccessState extends AskTrainerState {}
class GetAllClientsErrorState extends AskTrainerState {}

class SendMessageLoadingState extends AskTrainerState {}
class SendMessageSuccessState extends AskTrainerState {}
class SendMessageErrorState extends AskTrainerState {}

class PickFileLoadingState extends AskTrainerState {}
class PickFileSuccessState extends AskTrainerState {}
class PickFileErrorState extends AskTrainerState {}

class UploadFileLoadingState extends AskTrainerState {}
class UploadFileSuccessState extends AskTrainerState {}
class UploadFileErrorState extends AskTrainerState {}

class DownloadFileLoadingState extends AskTrainerState {}
class DownloadFileSuccessState extends AskTrainerState {}
class DownloadFileErrorState extends AskTrainerState {}
