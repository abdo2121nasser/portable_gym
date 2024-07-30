import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';

import '../../../managers_files/values_manager.dart';
import '../../general_blocks/square_element _block.dart';




class FavouriteGridViewBlock extends StatelessWidget {
  const FavouriteGridViewBlock({super.key});

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
        itemBuilder: (context, index) => InkWell(


            child: SquareElementBlock(
              isViewOnly: true,
              title: 'rt',
              calories: 'jfdfd',
              isFavouriteItem: true,
              imageLink: convertGoogleDriveLinkToStreamable('https://drive.google.com/file/d/1uVTgKy0ygSLWsRm6CP-rqcqh37IeMWFo/view?usp=drive_link'),
            )),
        itemCount: 7,
      ),
    );
  }
}
