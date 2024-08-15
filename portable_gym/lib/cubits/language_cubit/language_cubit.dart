import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  static LanguageCubit get(context) => BlocProvider.of(context);
  bool isArabicLanguage=false;
  var language=const Locale('en');
  changeLanguage(){
    isArabicLanguage=!isArabicLanguage;
    if(isArabicLanguage)
    {
      language=const Locale('ar');
      emit(ChangeLanguageToArabicState());

    }
    else
    {
      language=const Locale('en');
      emit(ChangeLanguageToEnglishState());

    }
  }

}
