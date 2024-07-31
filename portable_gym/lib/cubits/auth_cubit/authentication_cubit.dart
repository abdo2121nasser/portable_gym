import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/main_navigation_bar_screen.dart';
import 'package:portable_gym/screens/set_up_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../screens/authentication_screens/login_screen.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  // TextEditingController registerName = TextEditingController();
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

  // String nameValidation({required String name, required context}) {
  //   if (!registerName.text.isNotEmpty) {
  //     return S.of(context).theNameFieldIsEmpty;
  //   } else if (registerName.text
  //       .contains(RegExp(StringManager.nameExpression))) {
  //     return S.of(context).nameFieldShouldNotContainNumbers;
  //   } else
  //     return StringManager.trueWord;
  // }

  confirmPasswordValidation({required context}) {
    if (registerPassword.text != registerConfirmPassword.text) {
      return S.of(context).confirmPasswordIsNotEqualToPassword;
    } else {
      return StringManager.trueWord;
    }
  }
  //---------------------------validation----------------------------------

  clearLoginControllers(){
    loginEmail.clear();
    loginPassword.clear();
    emit(ClearLoginControllers());
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

  void loginProcess({required context}) {
    if (loginValidation(context: context) == true) {
      login(context: context);
    } else {
      getToastMessage(message: getLoginError(context: context));
    }
  }

  login({required context}) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginEmail.text,
      password: loginPassword.text,
    ).then((value)
    async {
      getToastMessage(message: S.of(context).success);
      emit(LoginSuccessState());
      bool hasData=await hasProfile(email: loginEmail.text,context: context);
      if( hasData ) {
        Get.to(const MainNavigationBarScreen());
      }
      else {
        Get.to(SetUpScreen(email: loginEmail.text,));
      }

    }).catchError((error)
    {
      emit(LoginErrorState());
      getToastMessage(message: error.toString().substring(36));

      debugPrint(error);
    });
    clearLoginControllers();
  }

  //-----------------------------login------------------------------------------

  clearRegisterControllers(){
    registerEmail.clear();
    registerPassword.clear();
    //registerName.clear();
    registerConfirmPassword.clear();
    emit(ClearRegisterControllers());
  }

  bool registerValidation({required context}) {
    if (emailValidation(email: registerEmail.text, context: context) ==
            StringManager.trueWord &&
        passwordValidation(password: registerPassword.text, context: context) ==
            StringManager.trueWord &&
      //  nameValidation(name: registerName.text, context: context) ==StringManager.trueWord &&

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
   // String nameError =nameValidation(name: registerName.text, context: context);
    String confirmPasswordError = confirmPasswordValidation(context: context);

    // if (nameError != StringManager.trueWord) {
    //   return nameError;
    // } else
      if (emailError != StringManager.trueWord) {
      return emailError;
    } else if (passwordError != StringManager.trueWord) {
      return passwordError;
    } else {
      return confirmPasswordError;
    }
  }

  void registerProcess({required context}) {
    if (registerValidation(context: context) == true) {
             register(context: context);
    } else {
      getToastMessage(message: getRegisterError(context: context));
    }
  }
  register({required context}) async {

    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: registerEmail.text,
      password: registerPassword.text,
    ).then((value)
     async {

      getToastMessage(message: S.of(context).success);
      emit(RegisterSuccessState());
        Get.to(SetUpScreen(email: registerEmail.text,));



     }).catchError((error)
    {
      getToastMessage(message: error.toString().substring(36));
      emit(RegisterErrorState());
      debugPrint(error);
    });
   clearRegisterControllers();
  }


//------------------------------register----------------------------------------

  void forgetPasswordPreprocess({required context}) {
    if (emailValidation(email: forgetPasswordEmail.text,context: context) == true) {
      forgetPassword(context: context);
    } else {
      getToastMessage(message: emailValidation(email: forgetPasswordEmail.text,context: context) );
    }
  }
  forgetPassword({required context}) async {
    emit(ForgetPasswordLoadingState());
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgetPasswordEmail.text)
        .then((value) {
      emit(ForgetPasswordSuccessState());
      getToastMessage(message: S
          .of(context)
          .success);
    })
        .catchError((error) {
      emit(ForgetPasswordErrorState());
      getToastMessage(message: S
          .of(context)
          .somethingWentWrong);
      debugPrint(error);
    });
    forgetPasswordEmail.clear();
  }



//-----------------------------forgetPassword-----------------------------------

  logOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      getToastMessage(message: S
          .of(context)
          .success);

        Get.offAll(LoginScreen());
    }).catchError((error) {
      getToastMessage(message: S
          .of(context)
          .somethingWentWrong);
      debugPrint(error);
    });
  }
//------------------------------logout------------------------------------------
 Future<bool> hasProfile({required String email,required context}) async {
  late  bool hasProfile;
    var data = await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).where(StringManager.userEmail,isEqualTo:email );
   await data.get().then((value) async {
     hasProfile= await value.docs.isNotEmpty;
    });
   return hasProfile;
  }
    
  }




