import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../resourses/blocks/profile_training_information_block.dart';
import '../../resourses/blocks/profile_upper_block.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              ProfileUpperBlock(),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.34,
              bottom: MediaQuery.of(context).size.height * 0.44,
              left: AppHorizontalSize.s22,
              right: AppHorizontalSize.s22,

              // left: MediaQuery.of(context).size.width*0.5,
              child: ProfileTrainingInformationBlock())
        ],
      ),
    );
  }
}
