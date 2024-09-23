import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/string_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/option_block.dart';



class LanguageSwitchBlock extends StatelessWidget {
  const LanguageSwitchBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22,vertical: AppVerticalSize.s5),
      child: OptionBlock(
        lable: S.of(context).language,
        icon: Icons.language,
        mySwitch:   Switch(value: isArabicLanguage(),
            onChanged: (f){
              changeLanguage();

            }),
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
