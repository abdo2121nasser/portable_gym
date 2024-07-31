import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/models/favourite_models/favourite_training_model.dart';

import '../../../managers_files/values_manager.dart';
import '../../general_blocks/square_element _block.dart';




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
          var languageModel=favouriteTrainingModels![index].getLanguageClass(context)??null;
          return InkWell(
              child: SquareElementBlock(
                isViewOnly: true,
                title: languageModel!.name??'ahmed',
                calories: 'hhhh',
                isFavouriteItem: true,
                imageLink: favouriteTrainingModels![index].videoLink!,
                isVideo: true,
              ));
        },
        itemCount: favouriteTrainingModels!.length??0,
      ),
    );
  }
}
