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
  List<ProfileModel> profileModels = [];
  TextEditingController messageController = TextEditingController();
  File? messageFile;
  String? fileName;
  String fileLink = '';

  Future<String?> hasChatWithMeBefore({
    required String docId1,
    required String docId2,
  }) async {
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .where(StringManager.senderAndReceiverDocId,
            whereIn: [docId1 + docId2, docId2 + docId1]).limit(1);
    await data.get().then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first;
      } else {
        return null;
      }
    }).catchError((error) {
      print(error);
    });
  }

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
      required String message}) async {
    emit(SendMessageLoadingState());
    var data =
        FirebaseFirestore.instance.collection(StringManager.collectionMessages);
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

  String getFileName({required String url}) => Uri.parse(url)
      .pathSegments
      .last
      .split('?')[0]; // Extract file name from URL

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

  sendMessageProcess(
      {required String senderDocId,
      required String senderAndReceiverDocId}) async {
    String message = messageController.text;
    messageController.clear();
    if (messageFile != null) {
      await uploadFileToCloud();
    }
    sendMessage(
        message: message,
        senderDocId: senderDocId,
        senderAndReceiverDocId: senderAndReceiverDocId);
  }
}
