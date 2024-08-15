import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../resourses/managers_files/string_manager.dart';

part 'ask_trainer_state.dart';

class AskTrainerCubit extends Cubit<AskTrainerState> {
  AskTrainerCubit() : super(AskTrainerInitial());
  static AskTrainerCubit get(context) => BlocProvider.of(context);

  List<ProfileModel> adminsProfileModels=[];

  getAllAdmins() async {
    adminsProfileModels.clear();
    emit(GetAllAdminsLoadingState());
   var data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles).where(StringManager.userIsClint,isEqualTo: false);
   await data.get().then((value)  {
     value.docs.forEach((element) {
   adminsProfileModels.add(ProfileModel.fromJson(json: element.data(), docId: element.id));
     });
       emit(GetAllAdminsSuccessState());
    }).catchError((error){
    emit(GetAllAdminsErrorState());
    debugPrint(error);
   });
  }



}
