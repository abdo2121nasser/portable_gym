import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/general_blocks/option_list_block.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var settCubit=SettingCubit.get(context);
          return Scaffold(
            appBar: GeneralAppBarBlock(title: S
                .of(context)
                .settings),
            body: Column(
              children: [
                OptionsListBlock(
                  lables: settCubit.getSettingOptionsLables(
                      context: context),
                  icons: settCubit.getSettingOptionsIcons(),
                  onClickFunction: (index,context) {
settCubit.settingNavigation(index: index,context: context);
                  },
                ),
              ],
            ),


          );
        },
      ),
    );
  }
}
