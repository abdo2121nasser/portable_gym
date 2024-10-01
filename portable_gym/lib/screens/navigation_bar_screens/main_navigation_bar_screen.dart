import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_coach/cubits/main_navigation_bar_cubit/main_navigation_bar_cubit.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/ask_trainer_blocks/linear_progress_indicator_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/font_manager.dart';
import 'package:my_coach/resourses/managers_files/style_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';
import 'package:intl/intl.dart';

import '../../cubits/profile_cubit/profile_cubit.dart';
import '../../generated/l10n.dart';

import '../app_bar_screens/profile_screen.dart';

class MainNavigationBarScreen extends StatelessWidget {
  const MainNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainNavigationBarCubit()),
        BlocProvider(
            create: (context) => ProfileCubit()..getUserDocId()),
      ],
      child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocConsumer<MainNavigationBarCubit,
                MainNavigationBarState>(
              listener: (context, state) {},
              builder: (context, state) {
                var profCubit = ProfileCubit.get(context);
                var navCubit = MainNavigationBarCubit.get(context);
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: ColorManager.kBlackColor,
                  appBar: AppBar(
                    toolbarHeight: AppVerticalSize.s80,
                    backgroundColor: ColorManager.kBlackColor,
                    automaticallyImplyLeading: false,
                    title: profCubit.profileModel != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      profCubit.profileModel!.nickName,
                                      style: getBoldStyle(
                                          fontSize: FontSize.s20,
                                          color: ColorManager.kPurpleColor,
                                          fontFamily:
                                              FontFamily.kPoppinsFont),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: AppVerticalSize.s5,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                     profCubit.profileModel!.isPremium?
                                     S.of(context).expireDate+DateFormat('d/M/yyyy').format(profCubit.profileModel!.expireDate??DateTime.now()):
                                      S.of(context).subTitle,
                                      style: getMediumStyle(
                                          fontSize: FontSize.s14,
                                          color: ColorManager.kWhiteColor,
                                          fontFamily:
                                              FontFamily.kLeagueSpartanFont),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const LinearProgressIndicatorBlock(isLoading: true),
                    actions: profCubit.profileModel != null
                        ? [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppHorizontalSize.s18),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ProfileScreen(
                                    profileModel: profCubit.profileModel!,
                                    profCubit: profCubit,
                                    isMyProfileScreen: true,
                                  ));
                                },
                                child: const Icon(
                                  Icons.person,
                                  color: ColorManager.kPurpleColor,
                                ),
                              ),
                            )
                          ]
                        : null,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: (newIndex) =>
                        navCubit.changeCurrentScreen(index: newIndex),
                    currentIndex: navCubit.currentIndex,
                    backgroundColor: ColorManager.kLightPurpleColor,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed, // Fixed

                    items: navCubit.items,
                  ),
                  body: navCubit.screens[navCubit.currentIndex],
                );
              },
            );
          },
        ),
    );
  }
}
