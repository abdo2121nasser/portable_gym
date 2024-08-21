import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

import '../work_out_models/training_model.dart';

class FavouriteTrainingModel {
  final TrainingEnglish english;
  final TrainingArabic? arabic;
  final String? videoLink;
  final String? startPeriod;
  final String? endPeriod;
  final String? docId;
  final String? trainingDocId;

  FavouriteTrainingModel({
    required this.english,
    required this.arabic,
    required this.videoLink,
    required this.startPeriod,
    required this.endPeriod,
    required this.docId,
    required this.trainingDocId,
  });

  factory FavouriteTrainingModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return FavouriteTrainingModel(
        videoLink:convertGoogleDriveLinkToStreamable(json[StringManager.trainingVideoLink]),
        startPeriod:json[StringManager.trainingStartPeriod] ,
        endPeriod:json[StringManager.trainingEndPeriod] ,
        english: TrainingEnglish.fromJson(json: json),
        arabic: TrainingArabic.fromJson(json: json),
        docId: docId,
      trainingDocId: json[ StringManager.trainingDocId]

    );
  }
  TrainingLanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic! : english!;
  }




}

