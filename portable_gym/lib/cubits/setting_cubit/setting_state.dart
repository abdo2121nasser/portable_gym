part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}
class SetControllersWithModelState extends SettingState {}
class ChangeAnswerValueState extends SettingState {}

// class GetUserDocIdLoadingState extends SettingState {}
// class GetUserDocIdSuccessState extends SettingState {}
// class GetUserDocIdErrorState extends   SettingState {}


class AddQuestionLoadingState extends SettingState {}
class AddQuestionSuccessState extends SettingState {}
class AddQuestionErrorState extends SettingState {}

class EditQuestionLoadingState extends SettingState {}
class EditQuestionSuccessState extends SettingState {}
class EditQuestionErrorState extends SettingState {}

class DeleteQuestionLoadingState extends SettingState {}
class DeleteQuestionSuccessState extends SettingState {}
class DeleteQuestionErrorState extends SettingState {}

class GetQuestionsLoadingState extends SettingState {}
class GetQuestionsSuccessState extends SettingState {}
class GetQuestionsErrorState extends SettingState {}

class AddAnswerLoadingState extends SettingState {}
class AddAnswerSuccessState extends SettingState {}
class AddAnswerErrorState extends SettingState {}

class EditAnswerLoadingState extends SettingState {}
class EditAnswerSuccessState extends SettingState {}
class EditAnswerErrorState extends SettingState {}

class DeleteAnswerLoadingState extends SettingState {}
class DeleteAnswerSuccessState extends SettingState {}
class DeleteAnswerErrorState extends SettingState {}

class CreateMealPlanLoadingState extends SettingState {}
class CreateMealPlanSuccessState extends SettingState {}
class CreateMealPlanErrorState extends SettingState {}
