import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:portable_gym/app_root/app_root.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/general_blocks/option_block.dart';
import '../../../resourses/blocks/general_blocks/option_list_block.dart';
import '../../../resourses/managers_files/font_manager.dart';
import '../../../resourses/managers_files/string_manager.dart';
import '../../../resourses/managers_files/style_manager.dart';
import '../../../resourses/managers_files/values_manager.dart';


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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22,vertical: AppVerticalSize.s5),
                        child: OptionBlock(
                          lable: S.of(context).language,
                          icon: Icons.language,
                          mySwitch:   Switch(value: isArabicLanguage(),
                              onChanged: (f){
                                changeLanguage();

                              }),
                        ),
                      ),


                    ],
                  ),


                );
              },
            ),
      ),
    );
  }
  bool isArabicLanguage(){
     return Get.locale?.languageCode=='ar';
  }
  void changeLanguage(){
    isArabicLanguage()?
    Get.updateLocale(const Locale('en')):
    Get.updateLocale(const Locale('ar'));
    saveLocalLanguage();
  }
 Future<void> saveLocalLanguage()
  async {
      await const FlutterSecureStorage()
        .write(key: StringManager.localLanguage,value: Get.locale!.languageCode);
  }
}

