import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';
import '../general_blocks/full_input_block.dart';
import '../general_blocks/general_button_block.dart';

class ProfileLowerBlock extends StatelessWidget {
  const ProfileLowerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var profCubit = ProfileCubit.get(context);
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.only(
                        right: AppHorizontalSize.s22,
                        left: AppHorizontalSize.s22,
                        bottom: AppVerticalSize.s20),
                    itemBuilder: (context, index) {
                      return index!=profCubit.getProfileControllers().length?  FullInputBlock(
                          lable: profCubit.getProfileInputsLables(
                              context: context)[index],
                          color: ColorManager.kPurpleColor,
                          controller: profCubit.getProfileControllers()[index],
                          onlyInteger: index>3,
                        ):GeneralButtonBlock(
                            lable: S.of(context).edit,
                            function: (){
                              profCubit.editUserData();
                            },
                            backgroundColor: ColorManager.kPurpleColor,
                            textStyle: getMediumStyle(
                                fontSize: FontSize.s20,
                                color:ColorManager.kWhiteColor,
                                fontFamily: FontFamily.kPoppinsFont));
                    }
                      ,

                    separatorBuilder: (context, index) => SizedBox(
                          height: AppVerticalSize.s5,
                        ),
                    itemCount: profCubit.getProfileControllers().length+1),
              ),


            ],
          ),
        );
      },
    );
  }
}
