import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/models/favourite_models/favourite_training_model.dart';
import 'package:portable_gym/resourses/models/work_out_models/training_model.dart';

import '../../../../screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/square_element _block.dart';

import 'package:intl/intl.dart';

class FavouriteGridViewBlock extends StatelessWidget {
  final List<FavouriteTrainingModel>? favouriteTrainingModels;
  const FavouriteGridViewBlock({super.key, this.favouriteTrainingModels});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: (1 / .8),
            mainAxisSpacing: 15),
        itemBuilder: (context, index) {
          var languageModel = favouriteTrainingModels == null
              ? null
              : favouriteTrainingModels![index].getLanguageClass(context);
          var time = favouriteTrainingModels == null
              ? null
              : DateFormat('HH:mm:ss').format(DateTime(
                  0,
                  0,
                  0,
                  favouriteTrainingModels![index].hour!,
                  favouriteTrainingModels![index].minute!,
                  favouriteTrainingModels![index].second!,
                ));
          return InkWell(
              onTap: () {
                if (favouriteTrainingModels != null) {
                  Get.to(() => ExerciseScreen(
                        trainingModel: TrainingModel(
                          english: favouriteTrainingModels![index].english,
                          arabic: favouriteTrainingModels![index].arabic,
                          videoLink: favouriteTrainingModels![index].videoLink,
                          hour: favouriteTrainingModels![index].hour,
                          minute: favouriteTrainingModels![index].minute!,
                          second: favouriteTrainingModels![index].second!,
                          docId: null,
                          bodyCategory: null,
                          isPaid: null,
                          level: null,
                          priority: null
                        ),
                      ));
                }
              },
              child: SquareElementBlock(
                isViewOnly: true,
                title: languageModel == null ? 'ahmed' : languageModel.name!,
                subValue: time ?? 'ahmed',
                isFavouriteItem: true,
                imageLink: favouriteTrainingModels == null
                    ? convertGoogleDriveLinkToStreamable(
                        "https://drive.google.com/uc?export=download&id=1-yk_Ei99v_clflTJYpAkSm9MMijiJ7l1")
                    : favouriteTrainingModels![index].videoLink!,
                isVideo: true,
                isTraining: true,
              ));
        },
        itemCount: favouriteTrainingModels == null
            ? 0
            : favouriteTrainingModels!.length,
      ),
    );
  }
}
