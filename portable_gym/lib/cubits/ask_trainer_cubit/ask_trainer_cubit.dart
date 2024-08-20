import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:portable_gym/resourses/models/ask_trainer_models/contact_message_model.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';
import 'package:portable_gym/resourses/services/dio_service.dart';

import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/ask_trainer_models/message_model.dart';

part 'ask_trainer_state.dart';

class AskTrainerCubit extends Cubit<AskTrainerState> {
  AskTrainerCubit() : super(AskTrainerInitial());

  static AskTrainerCubit get(context) => BlocProvider.of(context);

  Stream? messageStream;
  Stream<QuerySnapshot<Map<String, dynamic>>>? contactStream;
  List<ProfileModel> profileModels = [];
  TextEditingController messageController = TextEditingController();
  File? messageFile;
  String? fileName;
  String fileLink = '';


  //
  // Future<void> getAllClients({required String myDocId}) async {
  //   profileModels.clear();
  //   emit(GetAllClientsLoadingState());
  //
  //   var data = FirebaseFirestore.instance
  //       .collection(StringManager.collectionUserProfiles)
  //       .where(StringManager.userIsClint, isEqualTo: true);
  //   await data.get().then((value) async {
  //     await saveModelsData(value, myDocId);
  //     emit(GetAllClientsSuccessState());
  //   }).catchError((error) {
  //     emit(GetAllClientsErrorState());
  //     debugPrint("Error in getAllClients: $error");
  //   });
  // }
  // getAllAdmins({required String myDocId}) async {
  //   profileModels.clear();
  //   emit(GetAllAdminsLoadingState());
  //   var data = FirebaseFirestore.instance
  //       .collection(StringManager.collectionUserProfiles)
  //       .where(StringManager.userIsClint, isEqualTo: false);
  //   await data.get().then((value) async {
  //
  //     await saveModelsData(value, myDocId);
  //
  //     emit(GetAllAdminsSuccessState());
  //   }).catchError((error) {
  //     emit(GetAllAdminsErrorState());
  //     debugPrint(error);
  //   });
  // }

  Future<Map<String, dynamic>?> hasChatWithMeBefore({
    required String docId1,
    required String docId2,
  }) async {
    try {
      var data = FirebaseFirestore.instance
          .collection(StringManager.collectionContacts)
          .where(StringManager.senderAndReceiverDocId,
              whereIn: [docId1 + docId2, docId2 + docId1]).limit(1);

      var querySnapshot = await data.get();
      if (querySnapshot.docs.isNotEmpty) {

        return {
          'data': querySnapshot.docs.first.data(),
          'id': querySnapshot.docs.first.id
        };
      } else {

        return null;
      }
    } catch (error) {
      print("Error in hasChatWithMeBefore: $error");
      return null;
    }
  }
  Future<List<ProfileModel>> saveModelsData(
      QuerySnapshot<Map<String, dynamic>> value, String myDocId) async {
    print('Initial profileModels length: ${profileModels.length}');

    // Initialize a local list to avoid race conditions
    List<ProfileModel> localProfileModels = [];

    // Process each document
    for (var element in value.docs) {
      if (element.id != myDocId) {
        try {
          Map<String, dynamic>? contactMap = await hasChatWithMeBefore(
            docId1: myDocId,
            docId2: element.id,
          );

          ProfileModel profile;

          if (contactMap != null) {
            var contactTemp = ContactMessageModel.fromJson(
              json: contactMap['data'],
              contactDocId: contactMap['id'],
            );

            // Add profile with contact
            profile = ProfileModel.fromJson(
              json: element.data(),
              docId: element.id,
              contact: contactTemp,
            );
          } else {
            // Add profile without contact
            profile = ProfileModel.fromJson(
              json: element.data(),
              docId: element.id,
            );
          }

          localProfileModels.add(profile);
        } catch (e) {
          print('Error processing document ${element.id}: $e');
        }
      }
    }

    // Sort profiles
    localProfileModels.sort((a, b) {
      if (a.contactMessageModel == null && b.contactMessageModel == null) return 0;
      if (a.contactMessageModel == null) return 1;
      if (b.contactMessageModel == null) return -1;
      return b.contactMessageModel!.lastDate.compareTo(a.contactMessageModel!.lastDate);
    });

    profileModels.clear();
    profileModels.addAll(localProfileModels);

    print('Final profileModels length: ${profileModels.length}');
    return profileModels;
  }



  getAllAdminsStream({required String myDocId}) async {
    profileModels.clear();
 contactStream = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userIsClint, isEqualTo: false)
     .snapshots();

  }
  getAllClientsStream({required String myDocId}) async {
    profileModels.clear();
 contactStream = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userIsClint, isEqualTo: true).snapshots();

  }

  getAllFilteredUsers({required String myDocId, required bool isUserAdmin}) {
    clearProfileModels();
    if (isUserAdmin) {
      getAllAdminsStream(myDocId: myDocId);
    } else {
      getAllClientsStream(myDocId: myDocId);
    }
  }
  editProfileModel({required int index, required ContactMessageModel model}) {
    profileModels[index].contactMessageModel = model;
    emit(EditProfileModelState());
  }
  clearProfileModels(){
    profileModels.clear();
    emit(ClearProfileModelsState());
  }

  //-----------------------------messages------------------------------

  MessageModel setMessageModel(
      {required String senderDocId,
      required String senderAndReceiverDocId,
      required String message}) {
    return MessageModel(
        message: message,
        fileLink: fileLink ?? '',
        senderDocId: senderDocId,
        senderAndReceiverDocId: senderAndReceiverDocId,
        messageDate: DateTime.now());

  }

  sendMessage(
      {required String senderDocId,
      required String senderAndReceiverDocId,
      required String message,
      required String contactDocId}) async {
    emit(SendMessageLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .doc(contactDocId)
        .collection(StringManager.collectionMessages);
    await data
        .add(setMessageModel(
      message: message,
      senderDocId: senderDocId,
      senderAndReceiverDocId: senderAndReceiverDocId,
    ).toJson())
        .then((value) {
      emit(SendMessageSuccessState());
      messageController.clear();
    }).catchError((error) {
      emit(SendMessageErrorState());
      debugPrint(error);
    });
  }

  receiveStreamMessages({required String contactDocId})  {
   messageStream= FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .doc(contactDocId)
        .collection(StringManager.collectionMessages)
        .orderBy(StringManager.messageDate, descending: true)
        .snapshots();
  }


//-------------------------------files-------------------------------------
  removeFileFromSendingState() {
    messageFile = null;
    emit(RemoveFileFromSendingState());
  }

  pickFile() async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles();
      if (pickedFile != null) {
        messageFile = File(pickedFile.files.single.path!);
        fileName = pickedFile.files.single.name;
      }
      emit(PickFileSuccessState());
    } catch (error) {
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
      messageFile = null;
      emit(UploadFileSuccessState());
    }).catchError((error) {
      emit(UploadFileErrorState());
      debugPrint(error);
    });
  }

  String getFileName({required String url}) =>
      Uri.parse(url).pathSegments.last.split('?')[0];

  Future<void> downloadFileToDownloads(
      {required String url, required context}) async {
    try {
      emit(DownloadFileLoadingState());
      // Request storage permission
      final permissionStatus = await Permission.storage.request();
      if (!permissionStatus.isGranted) {
        throw Exception('Storage permission is not granted');
      }

      // Get file name from URL
      final fileName = getFileName(url: url);
      // Get the temporary directory path
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/$fileName';

      // Download the file
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 0),
        ),
      );
      // Create a temporary file and write the downloaded data
      final tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(response.data);

      // Save file to Downloads directory using MediaStore
      final downloadsPath = '/storage/emulated/0/Download/$fileName';
      final file = File(downloadsPath);

      if (await file.exists()) {
        await file.delete(); // Delete if file already exists
      }

      await tempFile.copy(downloadsPath); // Copy to Downloads directory
      emit(DownloadFileSuccessState());
      getToastMessage(message: S.of(context).success);

      await tempFile.delete(); // Delete the temporary file
    } catch (error) {
      emit(DownloadFileErrorState());
      debugPrint('Error downloading file: $error');
      getToastMessage(message: S.of(context).somethingWentWrong);
    }
  }

  //------------------------------- process -----------------------------

  sendMessageProcess(
      {required String senderDocId,
      required String receiverDocId,
      required ContactMessageModel contactModel}) async {
    String message = messageController.text;
    messageController.clear();
    await updateContactInformation(model: contactModel);
    if (messageFile != null) {
      await uploadFileToCloud();
    }

    sendMessage(
        contactDocId: contactModel.contactDocId,
        message: message,
        senderDocId: senderDocId,
        senderAndReceiverDocId: senderDocId + receiverDocId);
  }

  //-----------------------------contacts--------------------------------

  // streamContactInformation({
  //   required String senderDocId,
  // }) {
  //   contactStream = FirebaseFirestore.instance
  //       .collection(StringManager.collectionContacts)
  //       .where(StringManager.senderAndReceiverDocId, whereIn: [
  //     senderDocId]).orderBy(StringManager.lastDate,descending: true)
  //       .snapshots();
  // }

  updateContactInformation({required ContactMessageModel model}) {
    emit(UpdateContactLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .doc(model.contactDocId);
    data.set(model.toJson()).then((value) {
      emit(UpdateContactSuccessState());
    }).catchError((error) {
      emit(UpdateContactErrorState());
      debugPrint(error);
    });
  }

  Future<ContactMessageModel> createContact(
      {required ContactMessageModel model}) async {
    emit(CreateContactLoadingState());
    var data =
        FirebaseFirestore.instance.collection(StringManager.collectionContacts);
    await data.add(model.toJson()).then((value) {
      model.contactDocId = value.id;
      emit(CreateContactSuccessState());
    }).catchError((error) {
      emit(CreateContactErrorState());
      debugPrint(error);
    });
    return model;
  }
}
