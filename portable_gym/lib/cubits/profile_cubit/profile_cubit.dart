import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';

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

  ProfileModel? profileModel;

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


  getUserData() async {
   String email= FirebaseAuth.instance.currentUser!.email!;
   emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).where(StringManager.userEmail,isEqualTo:email ).get()
        .then((value) async {
         profileModel= ProfileModel.fromJson(json: value.docs[0].data(),docId: value.docs[0].id);
         emit(GetUserDataSuccessState());
    }).catchError((error){
      emit(GetUserDataErrorState());
               debugPrint(error);
    });
  }



}
