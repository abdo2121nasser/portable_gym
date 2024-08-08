part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class AddQuestionLoadingState extends SettingState {}
class AddQuestionSuccessState extends SettingState {}
class AddQuestionErrorState extends SettingState {}

class GetQuestionsLoadingState extends SettingState {}
class GetQuestionsSuccessState extends SettingState {}
class GetQuestionsErrorState extends SettingState {}

class AddAnswerLoadingState extends SettingState {}
class AddAnswerSuccessState extends SettingState {}
class AddAnswerErrorState extends SettingState {}
