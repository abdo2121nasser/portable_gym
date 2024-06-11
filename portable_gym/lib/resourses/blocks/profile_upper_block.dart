import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/personal_information_block.dart';
import 'package:portable_gym/resourses/blocks/profile_photo_block.dart';
import 'package:portable_gym/resourses/blocks/profile_training_information_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../generated/l10n.dart';
import '../managers_files/font_manager.dart';
import '../managers_files/style_manager.dart';




class ProfileUpperBlock extends StatelessWidget {
  const ProfileUpperBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),

    height: MediaQuery.of(context).size.height*0.38,
      color: ColorManager.kLightPurpleColor,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_left,
                color: ColorManager.kLimeGreenColor,
              ),
              Text(
                'My Profile',
                style: getBoldStyle(
                    fontSize: FontSize.s20,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),
            ],
          ),
          SizedBox(
              height: AppVerticalSize.s150,
              child: ProfilePhotoBlock(image: Image.asset(ImageManager.kSmileManImage).image,isEditable: false,)),
          PersonalInformationBlock(),

        ],
      ),
    );
  }
}
