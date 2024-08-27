import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'activity_model.g.dart';
@HiveType(typeId: 0)
class Activity {
  @HiveField(0)
  String englishCategoryName;
  @HiveField(1)
  String arabicCategoryName;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  DateTime period;
  @HiveField(4)
  String userDocId;

  Activity(
      {required this.englishCategoryName,
      required this.arabicCategoryName,
      required this.date,
      required this.period,
      required this.userDocId});
 String getCategoryName(context){
   return Localizations.localeOf(context).toString() == 'ar' ? arabicCategoryName : englishCategoryName;
  }

}
