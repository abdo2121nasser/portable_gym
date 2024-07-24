import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../resourses/blocks/profile_blocks/profile_lower_Block.dart';
import '../../resourses/blocks/profile_blocks/profile_option_list_block.dart';
import '../../resourses/blocks/profile_blocks/profile_options_block.dart';
import '../../resourses/blocks/profile_blocks/profile_training_information_block.dart';
import '../../resourses/blocks/profile_blocks/profile_upper_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var profCubit=ProfileCubit.get(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: GeneralAppBarBlock(title: S.of(context).myProfile,
            backgroundColor: ColorManager.kLightPurpleColor,
            titleColor: ColorManager.kWhiteColor,
            function:  (){
              profCubit.profileScreenNavigation(index: 0,isAppBar: true,context: context);
            }),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileUpperBlock(),
                SizedBox(
                  height: AppVerticalSize.s80,
                ),
                profCubit.isProfileLowerBlock?
                ProfileLowerBlock():
                ProfileOptionListBlock()
                
              ],
            ),
            Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.35,
                left: AppHorizontalSize.s22,
                right: AppHorizontalSize.s22,
                child: ProfileTrainingInformationBlock())
          ],
        ),
      );
  },
),
    );
  }
}
