import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/progress_tracking_blocks/vertical_information_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/image_manager.dart';
import '../../../models/profile_models/profile_model.dart';
import '../../general_blocks/profile_photo_block.dart';



class FullPersonalInformationBlock extends StatelessWidget {
  final ProfileModel profileModel;

  const FullPersonalInformationBlock({super.key,required this.profileModel});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.2,
      decoration: const BoxDecoration(
        color: ColorManager.kLightPurpleColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: AppVerticalSize.s10,),
            child:  VerticalInformationBlock(profileModel: profileModel),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height*0.18,
              width: MediaQuery.of(context).size.width*0.3 ,
              child: ProfilePhotoBlock(image: Image.network(profileModel.imageLink).image,isEditable: false,)),
        ],
      ),
    );
  }
}
