class FoodElementModel {
  final English english;
  final Arabic arabic;

  FoodElementModel({required this.english, required this.arabic});
}

abstract class LanguageClass {
  final String? name;
  final String? imageLink;
  final String? advantage;

  LanguageClass({
    required this.name,
    required this.imageLink,
    required this.advantage,
  });
}

class English extends LanguageClass {
  English({
    required String name,
    required String imageLink,
    required String protein,
    required String calories,
    required String carbohydrates,
    required String advantage,
    required String numberOfElement,
  }) : super(
          name: name,
          imageLink: imageLink,
          advantage: advantage,
        );

// factory English.fromJson({required Map<String, dynamic> json}) {
//   return English(
//     name: json[StringManager.trainingEnglishName],
//     numberOfReputation: json[StringManager.trainingEnglishNumberOfReputation],
//     instructions: json[StringManager.trainingEnglishInstruction],
//   );
//}
}

class Arabic extends LanguageClass {
  Arabic({
    required String name,
    required String imageLink,
    required String protein,
    required String calories,
    required String carbohydrates,
    required String advantage,
    required String numberOfElement,
  }) : super(
          name: name,
          imageLink: imageLink,
          advantage: advantage,
        );
// factory Arabic.fromJson({required Map<String, dynamic> json}) {
//   return Arabic(
//     name: json[StringManager.trainingArabicName],
//     numberOfReputation: json[StringManager.trainingArabicNumberOfReputation],
//     instructions: json[StringManager.trainingArabicInstruction],
//   );
// }
}
