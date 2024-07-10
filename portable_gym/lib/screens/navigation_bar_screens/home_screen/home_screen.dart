import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/home_cubit/home_cubit.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/general_blocks/horizontal_square_block.dart';
import '../../../resourses/blocks/general_blocks/section_title_block.dart';
import '../../../resourses/blocks/home_screen_blocks/top_menu_block.dart';
import '../../../resourses/blocks/home_screen_blocks/weekly_challanges_block.dart';
import '../../../resourses/blocks/general_blocks/square_element _block.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TopMenuBlock(),
              WeeklyChallangesBlock(
                lable: 'Plank with hip twist',
                title: S.of(context).weeklyChallenge,
              ),
              SectionTitleBlock(
                sectionLable: S.of(context).recommendations,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Row(
                  children: [
                    HorizontalSquareBlock(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
