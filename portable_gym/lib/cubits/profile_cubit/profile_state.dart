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

class UpdateImageFileOnCloudLoadingState extends ProfileState {}
class UpdateImageFileOnCloudSuccessState extends ProfileState {}
class UpdateImageFileOnCloudErrorState extends   ProfileState {}

class UpdateUserDataLoadingState extends ProfileState {}
class UpdateUserDataSuccessState extends ProfileState {}
class UpdateUserDataErrorState extends   ProfileState {}
