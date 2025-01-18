import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';
import 'package:my_coach/cubits/setting_cubit/setting_cubit.dart';
import 'package:my_coach/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/app_bar_blocks/settings_blocks/language_switch_block.dart';
import '../../../resourses/blocks/app_bar_blocks/settings_blocks/premium_block.dart';
import '../../../resourses/blocks/general_blocks/option_list_block.dart';


class SettingScreen extends StatelessWidget {
  final ProfileCubit profCubit;
  const SettingScreen({super.key,required this.profCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profCubit,
      child: BlocProvider(
        create: (context) => SettingCubit(),
        child: BlocConsumer<SettingCubit, SettingState>(
              listener: (context, state) {},
              builder: (context, state) {
                var settCubit = SettingCubit.get(context);
                return Scaffold(
                  appBar: GeneralAppBarBlock(title: S
                      .of(context)
                      .settings),
                  body: Column(
                    children: [
                      OptionsListBlock(
                        lables: settCubit.getSettingOptionsLables(
                            context: context),
                        icons: settCubit.getSettingOptionsIcons(context: context),
                        onClickFunction: (index, context) {
                          settCubit.settingNavigation(
                              index: index, context: context);
                        },
                      ),
                      // if(!profCubit.profileModel!.isPremium && profCubit.profileModel!.isClient)
                      //  PremiumBlock(profileModel: profCubit.profileModel!,),

                      const LanguageSwitchBlock(),


                    ],
                  ),


                );
              },
            ),
      ),
    );
  }

}

