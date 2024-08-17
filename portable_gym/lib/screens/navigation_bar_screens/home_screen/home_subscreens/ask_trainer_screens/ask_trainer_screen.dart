import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/option_list_block.dart';
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
        create: (context) => AskTrainerCubit()..getAllFilteredUsers(myDocId: profCubit.userDocId,isUserAdmin: profCubit.profileModel!.isClient),
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
                  OptionsListBlock(
                      lables: getAdminsLableList(
                          models: askCubit.profileModels),
                      icons: List<IconData>.generate(
                          getAdminsLableList(
                                  models: askCubit.profileModels)
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
                            senderDocId:
                                askCubit.profileModels[index].docId,
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

  List<String> getAdminsLableList({required List<ProfileModel> models}) {
    List<String> lables = [];
    models.forEach((element) {
      lables.add(element.nickName);
    });
    return lables;
  }
}
