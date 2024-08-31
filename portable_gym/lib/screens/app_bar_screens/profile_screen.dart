import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/answer_questions_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../resourses/blocks/profile_blocks/profile_lower_Block.dart';
import '../../resourses/blocks/general_blocks/option_list_block.dart';
import '../../resourses/blocks/profile_blocks/profile_training_information_block.dart';
import '../../resourses/blocks/profile_blocks/profile_upper_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/answers_of_questions_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit profCubit;
  final ProfileModel profileModel;
  final bool isMyProfileScreen;

  const ProfileScreen(
      {super.key,
      required this.profCubit,
      required this.profileModel,
      this.isMyProfileScreen = true});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profCubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: GeneralAppBarBlock(
              title: S.of(context).myProfile,
              backgroundColor: ColorManager.kLightPurpleColor,
              titleColor: ColorManager.kWhiteColor,
              titleFunction: () {
                profCubit.profileScreenNavigation(
                    index: 0, isAppBar: true, context: context);
              },
              actions: [
                if (profCubit.isProfileLowerBlock ||
                    (isMyProfileScreen == false &&
                        !profCubit.profileModel!.isClient))
                  IconButton(
                      onPressed: () {
                        if (profCubit.isProfileLowerBlock &&
                            isMyProfileScreen == true) {
                          Get.to(AnswerQuestionsScreen(
                            userNickName: '',
                            collection: StringManager.collectionUserProfiles,
                            profileModel: profileModel,
                            updateProfileQuestionsAnswersFunction:
                                (Map<String, dynamic> questionsMap) {
                              profCubit.editUserQuestionAnswers(
                                  questionsMap: questionsMap);
                            },
                          ));
                        } else {
                          Get.to(AnswersOfQuestionsScreen(
                            model: profileModel.questionModels,
                            isProfileViewOnly: true,
                            nutCubit: null,
                            clientDocId: '',
                            requestDocId: '',
                          ));
                        }
                      },
                      icon: const Icon(
                        Icons.info,
                        color: ColorManager.kWhiteColor,
                      ))
              ],
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isMyProfileScreen
                        ? ProfileUpperBlock(
                            profileModel: profCubit.profileModel!)
                        : ProfileUpperBlock(profileModel: profileModel),
                    SizedBox(
                      height: AppVerticalSize.s65,
                    ),
                    isMyProfileScreen
                        ? profCubit.isProfileLowerBlock
                            ? ProfileLowerBlock(
                                profileModel: profileModel,
                              )
                            : Expanded(
                                child: OptionsListBlock(
                                  lables: profCubit.getProfileOptionsLables(
                                      context: context),
                                  icons: profCubit.getProfileOptionsIcons(),
                                  onClickFunction: (index, context) {
                                    ProfileCubit.get(context)
                                        .profileScreenNavigation(
                                            index: index, context: context);
                                  },
                                ),
                              )
                        : ProfileLowerBlock(
                            profileModel: profileModel,
                          )
                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.28,
                    left: AppHorizontalSize.s22,
                    right: AppHorizontalSize.s22,
                    child: ProfileTrainingInformationBlock(
                      age: isMyProfileScreen
                          ? profCubit.profileModel!.age
                          : profileModel.age,
                      weight: isMyProfileScreen
                          ? profCubit.profileModel!.weight
                          : profileModel.weight,
                      height: isMyProfileScreen
                          ? profCubit.profileModel!.height
                          : profileModel.height,
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
