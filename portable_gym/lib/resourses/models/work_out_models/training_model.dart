import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

class TrainingModel {
  final English? english;
  final Arabic? arabic;
  final String? level;
  final String? videoLink;
  final String? bodyCategory;
  final int? hour;
  final int? minute;
  final int? second;
  final String? docId;

  TrainingModel({
    required this.english,
    required this.arabic,
    required this.level,
    required this.videoLink,
    required this.bodyCategory,
    required this.hour,
    required this.minute,
    required this.second,
    required this.docId
  });

  factory TrainingModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return TrainingModel(
      level: json[StringManager.trainingLevel],
      videoLink: json[StringManager.trainingVideoLink],
      bodyCategory: json[StringManager.trainingBodyCategory],
      hour: json[StringManager.trainingHourPeriod],
      minute: json[StringManager.trainingMinutePeriod],
      second: json[StringManager.trainingSecondPeriod],
      english: English.fromJson(json: json),
      arabic: Arabic.fromJson(json: json),
        docId: docId

    );
  }

  LanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic! : english!;
  }


}

abstract class LanguageClass {
  final String? name;
  final String? numberOfReputation;
  final String? instructions;

  LanguageClass({
    required this.name,
    required this.numberOfReputation,
    required this.instructions,
  });
}

class English extends LanguageClass {
  English({
    required String? name,
    required String? numberOfReputation,
    required String? instructions,
  }) : super(name: name, numberOfReputation: numberOfReputation, instructions: instructions);

  factory English.fromJson({required Map<String, dynamic> json}) {
    return English(
      name: json[StringManager.trainingEnglishName],
      numberOfReputation: json[StringManager.trainingEnglishNumberOfReputation],
      instructions: json[StringManager.trainingEnglishInstruction],
    );
  }
}

class Arabic extends LanguageClass {
  Arabic({
    required String? name,
    required String? numberOfReputation,
    required String? instructions,
  }) : super(name: name, numberOfReputation: numberOfReputation, instructions: instructions);

  factory Arabic.fromJson({required Map<String, dynamic> json}) {
    return Arabic(
      name: json[StringManager.trainingArabicName],
      numberOfReputation: json[StringManager.trainingArabicNumberOfReputation],
      instructions: json[StringManager.trainingArabicInstruction],
    );
  }
}
