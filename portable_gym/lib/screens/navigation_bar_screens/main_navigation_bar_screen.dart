import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/home_cubit/home_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/floating_menu_screens/profile_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/section_title_block.dart';
import '../../resourses/blocks/home_screen_blocks/top_menu_block.dart';
import '../../resourses/blocks/home_screen_blocks/top_menu_element_block.dart';

class MainNavigationBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.kBlackColor,
            appBar: AppBar(
              toolbarHeight: AppVerticalSize.s80,
              backgroundColor: ColorManager.kBlackColor,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 200,
                        child: Text(
                          'hi ahmed',
                          style: getBoldStyle(
                              fontSize: FontSize.s20,
                              color: ColorManager.kPurpleColor,
                              fontFamily: FontFamily.kPoppinsFont),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:  (context) => ProfileScreen(),));
                        },
                        child: const Icon(
                          Icons.person,
                          color: ColorManager.kPurpleColor,
                        ),
                      ),
                      SizedBox(
                        width: AppHorizontalSize.s10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppVerticalSize.s5,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).subTitle,
                          style: getMeduimStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.kWhiteColor,
                              fontFamily: FontFamily.kLeagueSpartanFont),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                const TopMenuBlock(),
                SectionTitleBlock(sectionLable: S.of(context).recommendations,)
              ],
            ),
          );
        },
      ),
    );
  }
}
