part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ChangeToProfileLowerBlockState extends   ProfileState {}
class ChangeToProfileScreenBlockState extends  ProfileState {}
class SetProfileControllersValuesState extends ProfileState {}

class GetUserDocIdLoadingState extends ProfileState {}
class GetUserDocIdSuccessState extends ProfileState {}
class GetUserDocIdErrorState extends   ProfileState {}

class GetUserDataLoadingState extends ProfileState {}
class GetUserDataSuccessState extends ProfileState {}
class GetUserDataErrorState extends ProfileState {}

class PickImageLoadingState extends ProfileState {}
class PickImageSuccessState extends ProfileState {}
class PickImageErrorState extends  ProfileState {}

class DeleteImageFileOnCloudLoadingState extends ProfileState {}
class DeleteImageFileOnCloudSuccessState extends ProfileState {}
class DeleteImageFileOnCloudErrorState extends   ProfileState {}

class UploadImageFileLoadingState extends ProfileState {}
class UploadImageFileSuccessState extends ProfileState {}
class UploadImageFileErrorState extends   ProfileState {}




class UpdateUserDataLoadingState extends ProfileState {}
class UpdateUserDataSuccessState extends ProfileState {}
class UpdateUserDataErrorState extends   ProfileState {}

class UpdateUserQuestionAnswerLoadingState extends ProfileState {}
class UpdateUserQuestionAnswerSuccessState extends ProfileState {}
class UpdateUserQuestionAnswerErrorState extends   ProfileState {}
