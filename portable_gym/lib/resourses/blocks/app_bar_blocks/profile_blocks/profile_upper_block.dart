import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/app_bar_blocks/profile_blocks/personal_information_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/profile_photo_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../models/profile_models/profile_model.dart';

class ProfileUpperBlock extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileUpperBlock({super.key,required this.profileModel});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var profCubit = ProfileCubit.get(context);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s22,
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          color: ColorManager.kLightPurpleColor,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state is GetUserDataLoadingState? const CircularProgressIndicator():
              Expanded(
                child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child:  InkWell(
                  onTap: profCubit.isProfileLowerBlock?(){
                   profCubit.pickImage();
                  }:null,
                  child: ProfilePhotoBlock(
                    image:profCubit.imageFile==null?
                    Image.network(
                    profileModel.imageLink).image:
                        Image.file(profCubit.imageFile!).image
                    ,
                    isEditable: profCubit.isProfileLowerBlock,
                  ),
                )),
          PersonalInformationBlock(fullName: profileModel.fullName,email: profileModel.email),
          SizedBox(
            height: AppVerticalSize.s10,
          ),
        ],
      ),
              )

            ],
          ),
        );
      },
    );
  }
}
