part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}
class ChangeLanguageToEnglishState extends LanguageState {}
class ChangeLanguageToArabicState extends LanguageState {}
