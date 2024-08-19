import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/option_list_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/ask_trainer_screens/chat_screen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/models/profile_models/profile_model.dart';

class AskTrainerScreen extends StatelessWidget {
  final ProfileCubit profCubit;

  const AskTrainerScreen({super.key, required this.profCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profCubit,
      child: BlocProvider(
        create: (context) => AskTrainerCubit()
          ..getAllFilteredUsers(
              myDocId: profCubit.userDocId,
              isUserAdmin: profCubit.profileModel!.isClient),
        child: BlocConsumer<AskTrainerCubit, AskTrainerState>(
          listener: (context, state) {},
          builder: (context, state) {
            var askCubit = AskTrainerCubit.get(context);
            return Scaffold(
              appBar: GeneralAppBarBlock(
                title: S.of(context).askTrainer,
              ),
              body: Column(
                children: [
                  state is GetAllClientsLoadingState ||
                          state is GetAllAdminsLoadingState
                      ? const Expanded(
                          child: Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.kPurpleColor,
                          ),
                        ))
                      : OptionsListBlock(
                          lables: getAdminsLableList(
                              profileModels: askCubit.profileModels,
                              chatWithMeModels:
                                  askCubit.chatWithMeBeforeModels),
                          icons: List<IconData>.generate(
                              getAdminsLableList(
                                      profileModels: askCubit.profileModels,
                                      chatWithMeModels:
                                          askCubit.chatWithMeBeforeModels)
                                  .length,
                              (index) => Icons.person,
                              growable: true),
                          onClickFunction: (index, context) {
                            Get.to(ChatScreen(
                              askCubit: askCubit,
                              profCubit: profCubit,
                              receiverModel: askCubit.profileModels[index],
                            ));
                            askCubit.receiveStreamMessages(
                              receiverDocId: profCubit.userDocId,
                              senderDocId: askCubit.profileModels[index].docId,
                            );
                          })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> getAdminsLableList({
    required List<ProfileModel> profileModels,
    required List<ProfileModel> chatWithMeModels,
  }) {
    List<String> lables = [];
    profileModels.forEach((element) {
      lables.add(element.nickName);
    });
    chatWithMeModels.forEach((element) {
      lables.add(element.nickName);
    });
    return lables;
  }
}
