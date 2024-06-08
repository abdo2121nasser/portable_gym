import 'package:flutter/material.dart';

import '../../managers_files/image_manager.dart';
import '../gender_block.dart';





class GenderSetUpBlock extends StatelessWidget {
  const GenderSetUpBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: Column(
      children: [
        GenderBlock(image: ImageManager.kMaleImage),
        GenderBlock(image: ImageManager.kFemaleImage) ,

      ],
    )) ;
  }
}
