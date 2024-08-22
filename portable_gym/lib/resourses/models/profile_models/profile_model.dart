import 'dart:convert';

import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/ask_trainer_models/contact_message_model.dart';

import '../setting_models/question_model.dart';

class ProfileModel {
  final String docId;
  final String fullName;
  final String nickName;
  final String email;
  final String phone;
  final String imageLink;
  final String level;
  final String gender;
  final int weight;
  final int height;
  final int age;
  final bool isPremium;
  final bool isClient;
  ContactMessageModel? contactMessageModel;
  List<QuestionModel> questionModels;

  ProfileModel(
      {required this.docId,
      required this.fullName,
      required this.nickName,
      required this.email,
      required this.phone,
      required this.imageLink,
      required this.level,
      required this.gender,
      required this.weight,
      required this.height,
      required this.age,
      required this.isPremium,
      required this.isClient,
      required this.questionModels,
      this.contactMessageModel});

  factory ProfileModel.fromJson(
      {required Map<String, dynamic> json,
      required String docId,
      ContactMessageModel? contact}) {

    return ProfileModel(
        docId: docId,
        fullName: json[StringManager.userFullName],
        nickName: json[StringManager.userNickName],
        email: json[StringManager.userEmail],
        phone: json[StringManager.userPhone],
        imageLink: json[StringManager.userImageLink],
        level: json[StringManager.userLevel],
        gender: json[StringManager.userGender],
        weight: json[StringManager.userWeight],
        height: json[StringManager.userHeight],
        age: json[StringManager.userAge],
        isPremium: json[StringManager.userIsPremium],
        isClient: json[StringManager.userIsClint],
        questionModels: List<QuestionModel>.from(
            json[StringManager.profileQuestionsAnswer]
                    [StringManager.questionsWithAnswer]
                .map((x) => QuestionModel.fromJson(json: x,docId: ''))),
        contactMessageModel: contact);
  }
}
