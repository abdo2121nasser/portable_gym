import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import 'body_parts_block.dart';

class ListBodyPartBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s16),
          itemBuilder: (context, index) => BodyPartBlock(),
          separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s22,),
          itemCount: 5),
    );
  }
}
