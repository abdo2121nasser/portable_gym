import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_coach/resourses/managers_files/toast_massage_manager.dart';
import 'package:my_coach/resourses/models/ask_trainer_models/contact_message_model.dart';
import 'package:my_coach/resourses/models/profile_models/profile_model.dart';
import '../../generated/l10n.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/ask_trainer_models/message_model.dart';
import 'package:intl/intl.dart';

part 'ask_trainer_state.dart';

class AskTrainerCubit extends Cubit<AskTrainerState> {
  AskTrainerCubit() : super(AskTrainerInitial());

  static AskTrainerCubit get(context) => BlocProvider.of(context);

  Stream? messageStream;
  Stream<QuerySnapshot<Map<String, dynamic>>>? contactStream;
  List<ProfileModel> profileModels = [];
  List<ProfileModel> contactsProfileModels = [];
  TextEditingController messageController = TextEditingController();
  File? messageFile;
  String? fileName;
  String fileLink = '';

  List<ProfileModel> saveModelsData(
      QuerySnapshot<Map<String, dynamic>> value, String myDocId) {
    List<ProfileModel> profilesWithContact = [];
    List<ProfileModel> profilesWithNoContact = [];
    List<ProfileModel> tempProfiles = [];
    for (var element in value.docs) {
      ContactMessageModel contact = ContactMessageModel.fromJson(
        json: element.data(),
        contactDocId: element.id,
      );
      if (contact.senderAndReceiverDocId.contains(myDocId)) {
        for (var profile in profileModels) {
          if (profile.docId == contact.docId1 ||
              profile.docId == contact.docId2) {
            profile.contactMessageModel = contact;
            profilesWithContact.add(profile);
            break;
          }
        }
      }
      //---------no contact
      for (var profile in profileModels) {
        if (!profilesWithContact.contains(profile)) {
          profilesWithNoContact.add(profile);
        }
      }
    }
    tempProfiles.addAll(profilesWithContact);
    tempProfiles.addAll(profilesWithNoContact);
    contactsProfileModels = sortingProfileModel(profileModels);
    return contactsProfileModels;
  }

  List<ProfileModel> sortingProfileModel(
      List<ProfileModel> localProfileModels) {
    localProfileModels.sort((a, b) {
      if (a.contactMessageModel == null && b.contactMessageModel == null) {
        return 0;
      }
      if (a.contactMessageModel == null) return 1;
      if (b.contactMessageModel == null) return -1;
      return b.contactMessageModel!.lastDate
          .compareTo(a.contactMessageModel!.lastDate);
    });
    return localProfileModels;
  }

  getAllAdmins({required String myDocId}) async {
    profileModels.clear();
    emit(GetAllAdminsLoadingState());
    FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userIsClint, isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        profileModels.add(
            ProfileModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetAllAdminsSuccessState());
    }).catchError((error) {
      emit(GetAllAdminsErrorState());
      debugPrint(error.toString());
    });
  }

  getAllClients({required String myDocId}) async {
    profileModels.clear();
    emit(GetAllClientsLoadingState());
    FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .where(StringManager.userIsClint, isEqualTo: true)
    .where(StringManager.userIsPremium, isEqualTo: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        profileModels.add(
            ProfileModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetAllClientsSuccessState());
    }).catchError((error) {
      emit(GetAllClientsErrorState());
      debugPrint(error.toString());
    });
  }

  getAllContactStream({
    required String myDocId,
  }) async {
    contactStream = FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .orderBy(StringManager.lastDate, descending: true)
        .snapshots();
  }

  getAllFilteredUsers(
      {required String myDocId, required bool isUserAdmin}) async {
    clearProfileModels();
    if (isUserAdmin) {
      await getAllAdmins(myDocId: myDocId);
    } else {
      await getAllClients(myDocId: myDocId);
    }
    await getAllContactStream(myDocId: myDocId);
  }

  editProfileModel({required int index, required ContactMessageModel model}) {
    profileModels[index].contactMessageModel = model;
    emit(EditProfileModelState());
  }

  clearProfileModels() {
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
      debugPrint(error.toString());
    });
  }

  receiveStreamMessages({required String contactDocId}) {
    messageStream = FirebaseFirestore.instance
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
    String date= DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    await FirebaseStorage.instance
        .ref()
        .child('${StringManager.messageFilesPathCloud}/${fileName!}/$date')
        .putFile(messageFile!)
        .then((result) async {
      fileLink = await result.ref.getDownloadURL();
      messageFile = null;
      emit(UploadFileSuccessState());
    }).catchError((error) {
      emit(UploadFileErrorState());
      debugPrint(error.toString());
    });
  }

  String getFileName({required String url}) =>
      Uri.parse(url).pathSegments.last.split('?')[0];

  Future<bool> isFileDownloaded({required String fileName}) async {
    final downloadsPath = await getExternalStorageDirectory();
    final filePath = '/storage/emulated/0/Download/$fileName';
    final file = File(filePath);
    return await file.exists();
  }

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
      debugPrint('Error downloading file: ${error.toString()}');
      getToastMessage(message: S.of(context).somethingWentWrong);
    }
  }

  downloadProcess({required String url, required context}) async {
    var isDownloaded = await isFileDownloaded(fileName: getFileName(url: url));
    if (isDownloaded) {
      openFile(fileName: getFileName(url: url));
    } else {
      downloadFileToDownloads(url: url, context: context);
    }
  }

  Future<void> openFile({required String fileName}) async {
    try {
      // Get the Downloads directory path
      final filePath = '/storage/emulated/0/Download/$fileName';
      final file = File(filePath);
      // Open the file
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        debugPrint('Error opening file: ${result.message}');
      }
    } catch (error) {
      debugPrint('Error opening file: ${error.toString()}');
    }
  }

  //------------------------------- process -----------------------------

  sendMessageProcess(
      {required ProfileModel senderModel,
      required ProfileModel receiverModel,
      required ContactMessageModel contactModel,
      required bool isDocId1,
      required Function(String) notifier
      }) async {
    String message=messageController.text;
    messageController.clear();
    await updateUnreadedContact(model: contactModel, isDocId1: isDocId1);
    if (messageFile != null) {
      await uploadFileToCloud();
    }

    await sendMessage(
        contactDocId: contactModel.contactDocId,
        message: message,
        senderDocId: senderModel.docId,
        senderAndReceiverDocId: senderModel.docId + receiverModel.docId);
    if(state is SendMessageSuccessState)
      {
       await notifier(message) ;
      }
  }

  //-----------------------------contacts--------------------------------

  ContactMessageModel setContactAttributes({required ProfileModel profile}) {
    int index = contactsProfileModels.indexOf(profile);
    profile.contactMessageModel =
        contactsProfileModels[index].contactMessageModel;
    return profile.contactMessageModel!;
  }

  setContactInformation({required ContactMessageModel model}) async {
    emit(UpdateContactLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .doc(model.contactDocId);
    await data.set(model.toJson()).then((value) {
      emit(UpdateContactSuccessState());
    }).catchError((error) {
      emit(UpdateContactErrorState());
      debugPrint(error.toString());
    });
  }

  updateUnreadedContact(
      {required ContactMessageModel model, required bool isDocId1}) async {
    emit(UpdateUnreadContactLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionContacts)
        .doc(model.contactDocId);
    await data
        .update(model.toJsonUnreadNumber(isDocId1: isDocId1))
        .then((value) {
      emit(UpdateUnreadContactSuccessState());
    }).catchError((error) {
      emit(UpdateUnreadContactErrorState());
      debugPrint(error.toString());
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
      debugPrint(error.toString());
    });
    return model;
  }
}
