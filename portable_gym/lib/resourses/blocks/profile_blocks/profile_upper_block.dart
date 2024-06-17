import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/personal_information_block.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/profile_photo_block.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/profile_training_information_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';




class ProfileUpperBlock extends StatelessWidget {
  const ProfileUpperBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22,),

    height: MediaQuery.of(context).size.height*0.38,
      color: ColorManager.kLightPurpleColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   height: AppVerticalSize.s10,
          // ),
          SizedBox(
              height: AppVerticalSize.s160,
              child: ProfilePhotoBlock(image: Image.asset(ImageManager.kSmileManImage).image,isEditable: false,)),
          const PersonalInformationBlock(),

        ],
      ),
    );
  }
}
