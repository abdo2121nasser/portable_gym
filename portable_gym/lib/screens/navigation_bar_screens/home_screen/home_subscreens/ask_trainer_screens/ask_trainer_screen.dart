import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';



class AskTrainerScreen extends StatelessWidget {
  const AskTrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:GeneralAppBarBlock(title: S.of(context).askTrainer,),

    );
  }
}
