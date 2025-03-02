part of 'ask_trainer_cubit.dart';

@immutable
abstract class AskTrainerState {}

class AskTrainerInitial extends AskTrainerState {}
class RemoveFileFromSendingState extends AskTrainerState {}
class EditProfileModelState extends AskTrainerState {}
class ClearProfileModelsState extends AskTrainerState {}
class SaveProfileModelsState extends AskTrainerState {}

class SaveProfileModelsLoadingState extends AskTrainerState {}
class SaveProfileModelsSuccessState extends AskTrainerState {}

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

class CreateContactLoadingState extends AskTrainerState {}
class CreateContactSuccessState extends AskTrainerState {}
class CreateContactErrorState extends AskTrainerState {}

class UpdateContactLoadingState extends AskTrainerState {}
class UpdateContactSuccessState extends AskTrainerState {}
class UpdateContactErrorState extends AskTrainerState {}

class UpdateUnreadContactLoadingState extends AskTrainerState {}
class UpdateUnreadContactSuccessState extends AskTrainerState {}
class UpdateUnreadContactErrorState extends AskTrainerState {}

class GetContactInformationLoadingState extends AskTrainerState {}
class GetContactInformationSuccessState extends AskTrainerState {}
class GetContactInformationErrorState extends AskTrainerState {}