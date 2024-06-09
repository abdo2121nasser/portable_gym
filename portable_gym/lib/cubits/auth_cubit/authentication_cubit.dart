import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  TextEditingController loginEmail=TextEditingController();
  TextEditingController loginPassword=TextEditingController();
  TextEditingController registerEmail=TextEditingController();
  TextEditingController registerName=TextEditingController();
  TextEditingController registerPassword=TextEditingController();
  TextEditingController registerConfirmPassword=TextEditingController();
  TextEditingController forgetPasswordEmail=TextEditingController();
  String nameValidation(String name)
  {
    if( !registerName.text.isNotEmpty)
    {
      return 'the name field is empty!!';
    }
    else if(registerName.text.contains(RegExp(r'[0-9]')))
    {
      return 'name field should not contain numbers';
    }
    else return 'true';
  }
  String emailValidation(String email)
  {
    if( !email.isNotEmpty)
    {
      return 'the email field is empty!!';
    }
    else if(email.contains('@')==false || email.contains('.com')==false || email.contains('gmail')==false)
    {
      return 'email field pattern is wrong';
    }
    else return 'true';
  }
  String passwordValidation(String password)
  {
    if( !password.isNotEmpty)
    {
      return 'the passsword field is empty!!';
    }
    else if(password.length < 8)
    {
      print(password.length);
      return 'password should be at least 8 numbers or characters';
    }
    else return 'true';
  }
  String registerValidation()
  {
    if(nameValidation(registerName.text)!='true')
    {
      return nameValidation(registerName.text);
    }
    else if(emailValidation(registerEmail.text)!='true')
    {
      return emailValidation(registerEmail.text);
    }
    else if(passwordValidation(registerPassword.text)!='true')
    {
      return passwordValidation(registerPassword.text);
    }
    else if (registerPassword.text!=registerConfirmPassword.text)
    {
      return 'password field is not equal confirmation password field';
    }
    else
    {
      return 'true';
    }
  }

}
