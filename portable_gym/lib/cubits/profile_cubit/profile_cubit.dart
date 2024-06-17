import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  bool isProfileLowerBlock = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  getProfileOptions({required context, required int index}) {
    List<String> profileOptionsLables = [
      S.of(context).myProfile,
      S.of(context).settings,
      S.of(context).logout,
    ];
    return profileOptionsLables[index];
  }

  profileScreenNavigation(
      {required int index, bool isAppBar = false, context}) {
    if (isAppBar == true && isProfileLowerBlock == true) {
      isProfileLowerBlock = false;
      emit(ChangeToProfileScreenBlockState());
    } else if (isAppBar == true && isProfileLowerBlock == false) {
      Navigator.pop(context);
    } else if (index == 0 && isAppBar == false) {
      isProfileLowerBlock = true;
      emit(ChangeToProfileLowerBlockState());
    }
  }

  getProfileControllers({required int index}) {
    List<TextEditingController> controllers = [
      nameController,
      emailController,
      phoneController,
      birthDateController,
      weightController,
      heightController
    ];
    return controllers[index];
  }
  getProfileInputsLables({required context,required int index}) {
    List<String> lables = [
      S.of(context).fullName,
      S.of(context).email,
      S.of(context).phone,
      S.of(context).birthDate,
      S.of(context).weight,
      S.of(context).height,
    ];
    return lables[index];
  }
  //todo setting screen is not made
}
