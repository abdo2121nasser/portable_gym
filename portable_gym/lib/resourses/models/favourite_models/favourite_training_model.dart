import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

class FavouriteTrainingModel {
  final English? english;
  final Arabic? arabic;
  final String? videoLink;
  final int? hour;
  final int? minute;
  final int? second;
  final String? docId;
  final String? trainingDocId;

  FavouriteTrainingModel({
    required this.english,
    required this.arabic,
    required this.videoLink,
    required this.hour,
    required this.minute,
    required this.second,
    required this.docId,
    required this.trainingDocId,
  });

  factory FavouriteTrainingModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return FavouriteTrainingModel(
        videoLink:convertGoogleDriveLinkToStreamable(json[StringManager.trainingVideoLink]),
        hour: json[StringManager.trainingHourPeriod],
        minute: json[StringManager.trainingMinutePeriod],
        second: json[StringManager.trainingSecondPeriod],
        english: English.fromJson(json: json),
        arabic: Arabic.fromJson(json: json),
        docId: docId,
      trainingDocId: json[ StringManager.trainingDocId]

    );
  }

  LanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic! : english!;
  }


}

abstract class LanguageClass {
  final String? name;
  final String? numberOfReputation;
  final String? numberOfRounds;
  final String? instructions;

  LanguageClass({
    required this.name,
    required this.numberOfReputation,
    required this.numberOfRounds,
    required this.instructions,
  });
}

class English extends LanguageClass {
  English({
    required String? name,
    required String? numberOfReputation,
    required String? numberOfRounds,
    required String? instructions,
  }) : super(name: name, numberOfReputation: numberOfReputation,
      numberOfRounds: numberOfRounds,
      instructions: instructions);

  factory English.fromJson({required Map<String, dynamic> json}) {
    return English(
      name: json[StringManager.trainingEnglishName],
      numberOfReputation: json[StringManager.trainingEnglishNumberOfReputation],
      numberOfRounds: json[StringManager.trainingEnglishNumberOfRounds],
      instructions: json[StringManager.trainingEnglishInstruction],
    );
  }
}

class Arabic extends LanguageClass {
  Arabic({
    required String? name,
    required String? numberOfReputation,
    required String? numberOfRounds,
    required String? instructions,
  }) : super(name: name, numberOfReputation: numberOfReputation,
      numberOfRounds: numberOfRounds,
      instructions: instructions);

  factory Arabic.fromJson({required Map<String, dynamic> json}) {
    return Arabic(
      name: json[StringManager.trainingArabicName],
      numberOfReputation: json[StringManager.trainingArabicNumberOfReputation],
      numberOfRounds: json[StringManager.trainingArabicNumberOfRounds],
      instructions: json[StringManager.trainingArabicInstruction],
    );
  }
}
