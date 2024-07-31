part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}
class ClearLoginControllers extends AuthenticationState {}
class ClearRegisterControllers extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}
class LoginSuccessState extends AuthenticationState {}
class LoginErrorState extends AuthenticationState {}

class RegisterLoadingState extends AuthenticationState {}
class RegisterSuccessState extends AuthenticationState {}
class RegisterErrorState extends AuthenticationState {}

class ForgetPasswordLoadingState extends AuthenticationState {}
class ForgetPasswordSuccessState extends AuthenticationState {}
class ForgetPasswordErrorState extends AuthenticationState {}

class SaveUserDataDocIdLoadingState extends AuthenticationState {}
class SaveUserDataDocIdSuccessState extends AuthenticationState {}
class SaveUserDataDocIdErrorState extends AuthenticationState {}

