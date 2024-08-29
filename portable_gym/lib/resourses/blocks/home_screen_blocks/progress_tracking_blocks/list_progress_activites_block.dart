import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/progress_tracking_blocks/progress_activity_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../models/progress_models/activity_model.dart';

class ListProgressActivitiesBlock extends StatelessWidget {
  final List<Activity> activities;
  const ListProgressActivitiesBlock({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            ProgressActivityBlock(activity: activities[index]),
        separatorBuilder: (context, index) => SizedBox(
              height: AppVerticalSize.s12,
            ),
        itemCount: activities.length);
  }
}
