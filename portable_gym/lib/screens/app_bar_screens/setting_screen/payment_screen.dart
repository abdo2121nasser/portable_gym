import 'package:flutter/material.dart';
import 'package:my_coach/resourses/blocks/general_blocks/option_list_block.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../resourses/managers_files/color_manager.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).subscriptiosWord,
        backgroundColor: ColorManager.kLightPurpleColor,
        titleColor: ColorManager.kWhiteColor,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: AppVerticalSize.s22,),
        child: OptionsListBlock(
          lables: ['firrst'],
          icons: [Icons.local_offer],
          onClickFunction: (int, BuildContext) {},
        ),
      ),
    );
  }
}
