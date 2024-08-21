import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

class BodyCategoryModel {
  final BodyCategoryEnglish? english;
  final BodyCategoryArabic? arabic;
  final String? level;
  final String? imageLink;
  final String? downloadFileLink;
  final int? hour;
  final int? minute;
  final int? second;
  final String? docId;

  BodyCategoryModel(
      {required this.english,
      required this.arabic,
      required this.level,
      required this.imageLink,
      this.downloadFileLink,
      required this.hour,
      required this.minute,
      required this.second,
      required this.docId});

  factory BodyCategoryModel.fromJson(
      {required Map<String, dynamic> json, required String docId}) {
    return BodyCategoryModel(
        level: json[StringManager.bodyCategoryLevel],
        imageLink: convertGoogleDriveLinkToStreamable(
            json[StringManager.bodyCategoryImageLink]),
        hour: json[StringManager.bodyCategoryTotalTimeHour],
        minute: json[StringManager.bodyCategoryTotalTimeMinute],
        second: json[StringManager.bodyCategoryTotalTimeSecond],
        english: BodyCategoryEnglish.fromJson(json: json),
        arabic: BodyCategoryArabic.fromJson(json: json),
        downloadFileLink:
            json[StringManager.bodyCategoryDownloadFilesLink] != null
                ? convertGoogleDriveLinkToStreamable(
                    json[StringManager.bodyCategoryDownloadFilesLink])
                : null,
        docId: docId);
  }

  Map<String, dynamic> toJson(
      {bool isAddFunction = true,
      String? bodyCategoryLevel,
      bool isDailyBodyCategory = false}) {
    return {
      StringManager.bodyCategoryEnglishTitle: english!.title,
   //   StringManager.bodyCategoryEnglishCalories: english!.calories,
      StringManager.bodyCategoryEnglishNumberOfExercises:
          english!.numberOfExercises,
      StringManager.bodyCategoryArabicTitle: arabic!.title,
 //     StringManager.bodyCategoryArabicCalories: arabic!.calories,
      StringManager.bodyCategoryArabicNumberOfExercises:
          arabic!.numberOfExercises,
      StringManager.bodyCategoryImageLink: imageLink,
      if (isDailyBodyCategory)
        StringManager.bodyCategoryDownloadFilesLink: downloadFileLink,
      if (isAddFunction) StringManager.bodyCategoryLevel: bodyCategoryLevel,
      StringManager.bodyCategoryTotalTimeHour: hour,
      StringManager.bodyCategoryTotalTimeMinute: minute,
      StringManager.bodyCategoryTotalTimeSecond: second,
    };
  }

  BodyCategoryLanguageClass getLanguageClass(context) {
    return Localizations.localeOf(context).toString() == 'ar'
        ? arabic!
        : english!;
  }
}

abstract class BodyCategoryLanguageClass {
  final String? title;
//  final String? calories;
  final String? numberOfExercises;

  BodyCategoryLanguageClass({
    required this.title,
  //  required this.calories,
    required this.numberOfExercises,
  });
}

class BodyCategoryEnglish extends BodyCategoryLanguageClass {
  BodyCategoryEnglish({
    required String? title,
 //   required String? calories,
    required String? numberOfExercises,
  }) : super(
            title: title,
         //   calories: calories,
            numberOfExercises: numberOfExercises);

  factory BodyCategoryEnglish.fromJson({required Map<String, dynamic> json}) {
    return BodyCategoryEnglish(
      title: json[StringManager.bodyCategoryEnglishTitle],
   //   calories: json[StringManager.bodyCategoryEnglishCalories],
      numberOfExercises:
          json[StringManager.bodyCategoryEnglishNumberOfExercises],
    );
  }
}

class BodyCategoryArabic extends BodyCategoryLanguageClass {
  BodyCategoryArabic({
    required String? title,
   // required String? calories,
    required String? numberOfExercises,
  }) : super(
            title: title,
      //      calories: calories,
            numberOfExercises: numberOfExercises);

  factory BodyCategoryArabic.fromJson({required Map<String, dynamic> json}) {
    return BodyCategoryArabic(
      title: json[StringManager.bodyCategoryArabicTitle],
  //    calories: json[StringManager.bodyCategoryArabicCalories],
      numberOfExercises:
          json[StringManager.bodyCategoryArabicNumberOfExercises],
    );
  }
}
