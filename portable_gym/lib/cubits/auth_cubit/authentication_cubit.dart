import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerName = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerConfirmPassword = TextEditingController();
  TextEditingController forgetPasswordEmail = TextEditingController();

  String emailValidation({required String email, required context}) {
    if (!email.isNotEmpty) {
      return S.of(context).theEmailFieldIsEmpty;
    } else if (email.contains(StringManager.gmailPattern) == false) {
      return S.of(context).emailFieldPatternIsWrong;
    } else
      return StringManager.trueWord;
  }

  String passwordValidation({required String password, required context}) {
    if (!password.isNotEmpty) {
      return S.of(context).thePasswordFieldIsEmpty;
    } else if (password.length < 8) {
      // print(password.length);
      return S.of(context).passwordShouldBeAtLeast8NumbersOrCharacters;
    } else
      return StringManager.trueWord;
  }

  bool loginValidation({required context}) {
    if (emailValidation(email: loginEmail.text, context: context) ==
            StringManager.trueWord &&
        passwordValidation(password: loginPassword.text, context: context) ==
            StringManager.trueWord) {
      return true;
    } else {
      return false;
    }
  }

  String getLoginError({required context}) {
    String emailError =
        emailValidation(email: loginEmail.text, context: context);
    String passwordError =
        passwordValidation(password: loginPassword.text, context: context);
    if (emailError != StringManager.trueWord) {
      return emailError;
    } else {
      return passwordError;
    }
  }

  void loginPreprocess({required context}) {
    if (loginValidation(context: context) == true) {
      //todo add login function
    } else {
      getToastMessage(message: getLoginError(context: context));
    }
  }

  login() {}

  //-----------------------------login------------------------------------------

  String nameValidation({required String name, required context}) {
    if (!registerName.text.isNotEmpty) {
      return S.of(context).theNameFieldIsEmpty;
    } else if (registerName.text
        .contains(RegExp(StringManager.nameExpression))) {
      return S.of(context).nameFieldShouldNotContainNumbers;
    } else
      return StringManager.trueWord;
  }

  confirmPasswordValidation({required context}) {
    if (registerPassword.text != registerConfirmPassword.text) {
      return S.of(context).confirmPasswordIsNotEqualToPassword;
    } else {
      return StringManager.trueWord;
    }
  }

  bool registerValidation({required context}) {
    if (emailValidation(email: registerEmail.text, context: context) ==
            StringManager.trueWord &&
        passwordValidation(password: registerPassword.text, context: context) ==
            StringManager.trueWord &&
        nameValidation(name: registerName.text, context: context) ==
            StringManager.trueWord &&
        confirmPasswordValidation(context: context) == StringManager.trueWord) {
      return true;
    } else {
      return false;
    }
  }

  String getRegisterError({required context}) {
    String emailError =
        emailValidation(email: registerEmail.text, context: context);
    String passwordError =
        passwordValidation(password: registerPassword.text, context: context);
    String nameError =
        nameValidation(name: registerName.text, context: context);
    String confirmPasswordError = confirmPasswordValidation(context: context);

    if (nameError != StringManager.trueWord) {
      return nameError;
    } else if (emailError != StringManager.trueWord) {
      return emailError;
    } else if (passwordError != StringManager.trueWord) {
      return passwordError;
    } else {
      return confirmPasswordError;
    }
  }

  void registerPreprocess({required context}) {
    if (registerValidation(context: context) == true) {
      //todo add register function
      // todo add create profile
    } else {
      getToastMessage(message: getRegisterError(context: context));
    }
  }
  register(){}


//------------------------------register----------------------------------------

  void forgetPasswordPreprocess({required context}) {
    if (emailValidation(email: forgetPasswordEmail.text,context: context) == true) {
      //todo add forget password function
    } else {
      getToastMessage(message: emailValidation(email: forgetPasswordEmail.text,context: context) );
    }
  }
  forgetPassword(){}
//-----------------------------forgetPassword-----------------------------------




}
