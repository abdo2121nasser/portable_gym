import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_coach/resourses/managers_files/toast_massage_manager.dart';
import 'package:my_coach/screens/navigation_bar_screens/main_navigation_bar_screen.dart';
import 'package:my_coach/screens/set_up_screen.dart';
import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../screens/authentication_screens/login_screen.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  static AuthenticationCubit get(context) => BlocProvider.of(context);
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  bool isVisibleLoginPassword = true;

  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerConfirmPassword = TextEditingController();
  bool isVisibleRegisterPassword = false;
  bool isVisibleRegisterConfirmPassword = false;
  TextEditingController forgetPasswordEmail = TextEditingController();
  bool isVisibleForgetPassword = false;
  TextEditingController registrationCodeController = TextEditingController();
  bool isAdmin = false;

  changeIsAdminValue() {
    isAdmin = !isAdmin;
    emit(ChangeIsAdminValue());
  }

  changePasswordVisibility({required String passwordLable}) {
    switch (passwordLable) {
      case 'login password':
        isVisibleLoginPassword = !isVisibleLoginPassword;
        break;
      case 'register password':
        isVisibleRegisterPassword = !isVisibleRegisterPassword;
        break;
      case 'register confirm password':
        isVisibleRegisterConfirmPassword = !isVisibleRegisterConfirmPassword;
        break;
      case 'forget password':
        isVisibleForgetPassword = !isVisibleForgetPassword;
        break;
    }
    emit(ChangePasswordVisibility());
  }

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

  clearLoginControllers() {
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
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: loginEmail.text,
      password: loginPassword.text,
    )
        .then((value) async {
      getToastMessage(message: S.of(context).success);
      emit(LoginSuccessState());
      // if (value.user!.emailVerified == false && false)
      // //todo delete the and false
      // {
      //   await sendEmailVerification(context);
      // } else {
      //   bool hasData =
      //       await hasProfile(email: loginEmail.text, context: context);
      //   if (hasData) {
      //     Get.offAll(const MainNavigationBarScreen());
      //   } else {
      //     Get.to(SetUpScreen(
      //       email: loginEmail.text,
      //       isAdmin: isAdmin,
      //     ));
      //   }
      // }
    }).catchError((error) {
      emit(LoginErrorState());
      getToastMessage(message: S.of(context).somethingWentWrong);

      debugPrint(error.toString());
    });
    clearLoginControllers();
  }

  //-----------------------------login------------------------------------------

  clearRegisterControllers() {
    registerEmail.clear();
    registerPassword.clear();
    //registerName.clear();
    registerConfirmPassword.clear();
    registrationCodeController.clear();
    emit(ClearRegisterControllers());
  }

  bool registerValidation({required context}) {
    if (emailValidation(email: registerEmail.text, context: context) ==
            StringManager.trueWord &&
        passwordValidation(password: registerPassword.text, context: context) ==
            StringManager.trueWord &&
        //  nameValidation(name: registerName.text, context: context) ==StringManager.trueWord &&

        confirmPasswordValidation(context: context) == StringManager.trueWord) {
      if (isAdmin) {
        if (registrationCodeController.text.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }
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
    } else if (confirmPasswordError != StringManager.trueWord) {
      return confirmPasswordError;
    } else {
      return S.of(context).registrationCodeErrorMessage;
    }
  }

  Future<void> registerProcess({required context}) async {
    print(registerValidation(context: context) == true);
    if (registerValidation(context: context) == true) {
      if (isAdmin) {
        await adminRegistration(context);
      } else {
        await clintRegistration(context);
      }
    } else {
      getToastMessage(message: getRegisterError(context: context));
    }
    // clearRegisterControllers();
  }

  Future<void> clintRegistration(context) async {
      await register(context);
    if (state is RegisterSuccessState) {
      await sendEmailVerification(context);
      Get.back();
    }
  }

  Future<void> adminRegistration(context) async {
    if (registrationCodeController.text == await getRegistrationCode()) {
      await clintRegistration(context);
    } else {
      getToastMessage(message: S.of(context).registrationCodeIsWrong);
    }
  }

  register(context) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: registerEmail.text,
      password: registerPassword.text,
    )
        .then((value) async {
      emit(RegisterSuccessState());
    }).catchError((error) {
      getToastMessage(message: S.of(context).somethingWentWrong);
      emit(RegisterErrorState());
      debugPrint(error.toString());
    });
  }

  sendEmailVerification(context) async {
    emit(EmailVerificationLoadingState());
    await FirebaseAuth.instance.currentUser!
        .sendEmailVerification()
        .then((value) {
      getToastMessage(message: S.of(context).emailVerificationMessage);
      emit(EmailVerificationSuccessState());
    }).catchError((error) {
      emit(EmailVerificationErrorState());
      debugPrint(error.toString());
      getToastMessage(message: S.of(context).somethingWentWrong);
    });
  }

//------------------------------register----------------------------------------

  void forgetPasswordPreprocess({required context}) {
    if (emailValidation(email: forgetPasswordEmail.text, context: context) ==
        true) {
      forgetPassword(context: context);
    } else {
      getToastMessage(
          message: emailValidation(
              email: forgetPasswordEmail.text, context: context));
    }
  }

  forgetPassword({required context}) async {
    emit(ForgetPasswordLoadingState());
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: forgetPasswordEmail.text)
        .then((value) {
      emit(ForgetPasswordSuccessState());
      getToastMessage(message: S.of(context).success);
    }).catchError((error) {
      emit(ForgetPasswordErrorState());
      getToastMessage(message: S.of(context).somethingWentWrong);
      debugPrint(error.toString());
    });
    forgetPasswordEmail.clear();
  }

//-----------------------------forgetPassword-----------------------------------

  logOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      getToastMessage(message: S.of(context).success);
      deleteAllLocalStoredData();
      Get.offAll(const LoginScreen());
    }).catchError((error) {
      getToastMessage(message: S.of(context).somethingWentWrong);
      debugPrint(error.toString());
    });
  }

  deleteAllLocalStoredData() async {
    await const FlutterSecureStorage().delete(key: StringManager.userDocId);
  }

//------------------------------logout------------------------------------------
  Future<bool> hasProfile({required String email, required context}) async {
    bool hasProfile = false;
    var data = await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userEmail, isEqualTo: email);
    await data.get().then((value) async {
      if (value.docs.isNotEmpty) {
        hasProfile = true;
        saveUserDocId(userDocId: value.docs.first.id);
      }
    });
    return hasProfile;
  }

  saveUserDocId({required String userDocId}) async {
    emit(SaveUserDataDocIdLoadingState());
    await const FlutterSecureStorage()
        .write(key: StringManager.userDocId, value: userDocId)
        .then((value) {
      emit(SaveUserDataDocIdSuccessState());
    }).catchError((error) {
      emit(SaveUserDataDocIdErrorState());
      debugPrint(error.toString());
    });
  }

  //-----------------------------------registration code----------------------
  Future<String> getRegistrationCode() async {
    return await FirebaseFirestore.instance
        .collection(StringManager.registrationCodeCollection)
        .get()
        .then((value) {
      return value.docs.first[StringManager.registrationCode];
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
