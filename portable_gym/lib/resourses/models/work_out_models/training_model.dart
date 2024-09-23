import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/google_drive_function_manager.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';

class TrainingModel {
  final TrainingEnglish? english;
  final TrainingArabic? arabic;
  final String? level;
  final String? videoLink;
  final String? bodyCategory;
  final bool?  isPaid;
  final int? priority;
  final String? startPeriod;
  final String? endPeriod;

  final String? docId;

  TrainingModel({
    required this.english,
    required this.arabic,
    required this.level,
    required this.videoLink,
    required this.bodyCategory,
    required this.isPaid,
    required this.priority,
    required this.startPeriod,
    required this.endPeriod,
    required this.docId
  });

  factory TrainingModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return TrainingModel(
      level: json[StringManager.trainingLevel],
      videoLink:convertGoogleDriveLinkToStreamable( json[StringManager.trainingVideoLink]),
      bodyCategory: json[StringManager.trainingBodyCategory],
      isPaid: json[StringManager.trainingIsPaid],
      priority: json[StringManager.trainingPriority],
      english: TrainingEnglish.fromJson(json: json),
      arabic: TrainingArabic.fromJson(json: json),
        startPeriod:json[StringManager.trainingStartPeriod]??'' ,
        endPeriod:json[StringManager.trainingEndPeriod]??'' ,
        docId: docId

    );
  }
  Map<String,dynamic> toJson(){
    return {
      StringManager.trainingEnglishName: english!.name,
      StringManager.trainingEnglishNumberOfReputation:
      english!.numberOfReputation,
      StringManager.trainingEnglishNumberOfRounds:
     english!.numberOfRounds,
      StringManager.trainingEnglishInstruction:
      english!.instructions,
      StringManager.trainingArabicName: arabic!.name,
      StringManager.trainingArabicNumberOfReputation:
      arabic!.numberOfReputation,
      StringManager.trainingArabicNumberOfRounds:
      arabic!.numberOfRounds,
      StringManager.trainingArabicInstruction:
      arabic!.instructions,
    StringManager.trainingLevel:level,
      StringManager.trainingBodyCategory: bodyCategory,
      StringManager.trainingVideoLink: videoLink,
      StringManager.trainingPriority: priority  ,
      StringManager.trainingIsPaid: isPaid,
      StringManager.trainingStartPeriod: startPeriod,
      StringManager.trainingEndPeriod: endPeriod,
    };
}




  TrainingLanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic! : english!;
  }


}

abstract class TrainingLanguageClass {
  final String? name;
  final String? numberOfReputation;
  final String? numberOfRounds;
  final String? instructions;

  TrainingLanguageClass({
    required this.name,
    required this.numberOfReputation,
    required this.numberOfRounds,
    required this.instructions,
  });
}

class TrainingEnglish extends TrainingLanguageClass {
  TrainingEnglish({
    required String? name,
    required String? numberOfReputation,
    required String? numberOfRounds,
    required String? instructions,
  }) : super(name: name, numberOfReputation: numberOfReputation,
      numberOfRounds: numberOfRounds,
      instructions: instructions);

  factory TrainingEnglish.fromJson({required Map<String, dynamic> json}) {
    return TrainingEnglish(
      name: json[StringManager.trainingEnglishName],
      numberOfReputation: json[StringManager.trainingEnglishNumberOfReputation],
      numberOfRounds: json[StringManager.trainingEnglishNumberOfRounds]??'1',
      instructions: json[StringManager.trainingEnglishInstruction],
    );
  }
}

class TrainingArabic extends TrainingLanguageClass {
  TrainingArabic({
    required String? name,
    required String? numberOfReputation,
    required String? numberOfRounds,
    required String? instructions,
  }) : super(name: name, numberOfReputation: numberOfReputation,
      numberOfRounds: numberOfRounds,
      instructions: instructions);

  factory TrainingArabic.fromJson({required Map<String, dynamic> json}) {
    return TrainingArabic(
      name: json[StringManager.trainingArabicName],
      numberOfReputation: json[StringManager.trainingArabicNumberOfReputation],
      numberOfRounds: json[StringManager.trainingArabicNumberOfRounds]??'1',
      instructions: json[StringManager.trainingArabicInstruction],
    );
  }
}
