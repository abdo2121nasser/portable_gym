class RecipeModel {
  final English english;
  final Arabic arabic;

  RecipeModel({required this.english, required this.arabic});
}

abstract class LanguageClass {
  final String? name;
  final String? imageLink;
  final String? protein;
  final String? calories;
  final String? carbohydrates;
  final String? advantage;
  final String? numberOfElement;

  LanguageClass({
    required this.name,
    required this.imageLink,
    required this.protein,
    required this.calories,
    required this.carbohydrates,
    required this.advantage,
    required this.numberOfElement,
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
          protein: protein,
          calories: calories,
          carbohydrates: carbohydrates,
          advantage: advantage,
          numberOfElement: numberOfElement,
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
          protein: protein,
          calories: calories,
          carbohydrates: carbohydrates,
          advantage: advantage,
          numberOfElement: numberOfElement,
        );
  // factory Arabic.fromJson({required Map<String, dynamic> json}) {
  //   return Arabic(
  //     name: json[StringManager.trainingArabicName],
  //     numberOfReputation: json[StringManager.trainingArabicNumberOfReputation],
  //     instructions: json[StringManager.trainingArabicInstruction],
  //   );
  // }
}
