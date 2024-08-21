import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../resourses/blocks/profile_blocks/profile_lower_Block.dart';
import '../../resourses/blocks/general_blocks/option_list_block.dart';
import '../../resourses/blocks/profile_blocks/profile_training_information_block.dart';
import '../../resourses/blocks/profile_blocks/profile_upper_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit profCubit;
  final ProfileModel profileModel;
  final bool isMyProfileScreen;


  const ProfileScreen({super.key,required this.profCubit,required this.profileModel,
   this.isMyProfileScreen=false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profCubit,
  child: BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: GeneralAppBarBlock(
              title: S.of(context).myProfile,
              backgroundColor: ColorManager.kLightPurpleColor,
              titleColor: ColorManager.kWhiteColor,
              titleFunction: () {
                profCubit.profileScreenNavigation(
                    index: 0, isAppBar: true, context: context);
              }),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   ProfileUpperBlock(profileModel: profileModel),
                  SizedBox(
                    height: AppVerticalSize.s65,
                  ),
                  profCubit.isProfileLowerBlock &&
                          profCubit.profileModel != null

                      ? const ProfileLowerBlock()
                      :  Expanded(
                        child: OptionsListBlock(
                    lables: profCubit.getProfileOptionsLables(context: context),
                    icons: profCubit.getProfileOptionsIcons(),
                    onClickFunction: (index,context){
                        ProfileCubit.get(context).profileScreenNavigation(index: index,context: context);
                    },
                  ),
                      )
                ],
              ),
              profCubit.profileModel != null
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.28,
                      left: AppHorizontalSize.s22,
                      right: AppHorizontalSize.s22,
                      child: ProfileTrainingInformationBlock(
                        age: profCubit.profileModel!.age,
                        weight: profCubit.profileModel!.weight,
                        height: profCubit.profileModel!.height,
                      ))
                  : const SizedBox(),
            ],
          ),
        );
      },
    ),
);
  }
}
