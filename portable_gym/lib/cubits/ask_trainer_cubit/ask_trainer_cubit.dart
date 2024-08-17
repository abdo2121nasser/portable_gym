import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/ask_trainer_models/message_model.dart';

part 'ask_trainer_state.dart';

class AskTrainerCubit extends Cubit<AskTrainerState> {
  AskTrainerCubit() : super(AskTrainerInitial());
  static AskTrainerCubit get(context) => BlocProvider.of(context);

  Stream? messageStream;
  List<ProfileModel> profileModels = [];
  TextEditingController messageController = TextEditingController();
  File? messageFile;
  String? fileName;
  String fileLink = '';

  getAllAdmins({required String myDocId}) async {
    profileModels.clear();
    emit(GetAllAdminsLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userIsClint, isEqualTo: false);
    await data.get().then((value) {
      value.docs.forEach((element) {
        if (element.id != myDocId) {
          profileModels.add(
              ProfileModel.fromJson(json: element.data(), docId: element.id));
        }
      });
      emit(GetAllAdminsSuccessState());
    }).catchError((error) {
      emit(GetAllAdminsErrorState());
      debugPrint(error);
    });
  }

  getAllClients({required String myDocId}) async {
    profileModels.clear();
    emit(GetAllClientsLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userIsClint, isEqualTo: true);
    await data.get().then((value) {
      value.docs.forEach((element) {
        if (element.id != myDocId) {
          profileModels.add(
              ProfileModel.fromJson(json: element.data(), docId: element.id));
        }
      });
      emit(GetAllClientsSuccessState());
    }).catchError((error) {
      emit(GetAllClientsErrorState());
      debugPrint(error);
    });
  }

  getAllFilteredUsers({required String myDocId, required bool isUserAdmin}) {
    if (isUserAdmin) {
      getAllAdmins(myDocId: myDocId);
    } else {
      getAllClients(myDocId: myDocId);
    }
  }

  //-----------------------------messages------------------------------
  MessageModel setMessageModel(
      {required String senderDocId, required String senderAndReceiverDocId,required String message}) {
    return MessageModel(
        message: message,
        fileLink: fileLink??'',
        senderDocId: senderDocId,
        senderAndReceiverDocId: senderAndReceiverDocId,
        messageDate: DateTime.now());
  }

  sendMessage(
      {required String senderDocId, required String senderAndReceiverDocId,required String message}) async {
    emit(SendMessageLoadingState());
    var data =
        FirebaseFirestore.instance.collection(StringManager.collectionMessages);
  await  data
        .add(setMessageModel(
    message: message,
                senderDocId: senderDocId,
                senderAndReceiverDocId: senderAndReceiverDocId,)
            .toJson())
        .then((value) {
      emit(SendMessageSuccessState());
      messageController.clear();
    }).catchError((error) {
      emit(SendMessageErrorState());
      debugPrint(error);
    });
  }

  receiveStreamMessages({
    required String senderDocId,
    required String receiverDocId,
  }) {
    String senderToReceiver = senderDocId + receiverDocId;
    String receiverToSender = receiverDocId + senderDocId;

    messageStream = FirebaseFirestore.instance
        .collection(StringManager.collectionMessages)
        .where(StringManager.senderAndReceiverDocId,
            whereIn: [senderToReceiver, receiverToSender])
        .orderBy(StringManager
            .messageDate) // This can be uncommented to order by message date
        .snapshots();
  }

//-------------------------------files-------------------------------------
  pickFile() async {
    try{
      final pickedFile = await FilePicker.platform.pickFiles();
      if (pickedFile != null)
        {
          messageFile = File(pickedFile.files.single.path!);
          fileName = pickedFile.files.single.name;
        }
        emit(PickFileSuccessState());
    }catch(error){
      emit(PickFileErrorState());
      debugPrint('no image selected');
    }
    emit(PickFileLoadingState());

  }

  uploadFileToCloud() async {
    emit(UploadFileLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child(fileName!)
        .putFile(messageFile!)
        .then((result) async {
      fileLink = await result.ref.getDownloadURL();
      messageFile=null;
      emit(UploadFileSuccessState());
    }).catchError((error) {
      emit(UploadFileErrorState());
      debugPrint(error);
    });
  }

  sendMessageProcess({required String senderDocId, required String senderAndReceiverDocId}) async {
    String message=messageController.text;
    messageController.clear();
    if(messageFile!=null) {
      await uploadFileToCloud();
    }
      sendMessage(
          message: message,
          senderDocId: senderDocId, senderAndReceiverDocId: senderAndReceiverDocId);
  }
}
