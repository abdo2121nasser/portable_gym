import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/ask_trainer_models/contact_message_model.dart';

import '../setting_models/question_model.dart';

class ProfileModel {
  final String docId;
  final String fullName;
  final String nickName;
  final String email;
  final String phone;
  final String imageLink;
  // final String level;
  final String gender;
  final int weight;
  final int height;
  final int age;
  final bool isPremium;
  final bool isClient;
  ContactMessageModel? contactMessageModel;
  List<QuestionModel> questionModels;
  final String deviceToken;
 final DateTime? expireDate;

  ProfileModel(
      {required this.docId,
      required this.fullName,
      required this.nickName,
      required this.email,
      required this.phone,
      required this.imageLink,
      // required this.level,
      required this.gender,
      required this.weight,
      required this.height,
      required this.age,
      required this.isPremium,
      required this.isClient,
      required this.questionModels,
        required this.deviceToken,
      this.contactMessageModel,
      this.expireDate
      });

  factory ProfileModel.fromJson(
      {required Map<String, dynamic> json,
      required String docId,
      ContactMessageModel? contact}) {
    Timestamp? timestamp=json[StringManager.userExpirationDate];
    DateTime? dateTime=timestamp?.toDate();

    return ProfileModel(
        docId: docId,
        fullName: json[StringManager.userFullName],
        nickName: json[StringManager.userNickName],
        email: json[StringManager.userEmail],
        phone: json[StringManager.userPhone],
        imageLink: json[StringManager.userImageLink],
        // level: json[StringManager.userLevel],
        gender: json[StringManager.userGender],
        weight: json[StringManager.userWeight],
        height: json[StringManager.userHeight],
        age: json[StringManager.userAge],
        isPremium: json[StringManager.userIsPremium],
        isClient: json[StringManager.userIsClint],
        deviceToken: json[StringManager.deviceToken]??'',
        questionModels:json[StringManager.profileQuestionsAnswer] ==null?[]:
        List<QuestionModel>.from(
            json[StringManager.profileQuestionsAnswer]
                    [StringManager.questionsWithAnswer]
                .map((x) => QuestionModel.fromJson(json: x,docId: ''))),
        contactMessageModel: contact,
    expireDate: dateTime


    );
  }
}
