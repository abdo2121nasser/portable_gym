import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/option_list_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/models/ask_trainer_models/contact_message_model.dart';
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
              body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: askCubit.contactStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.kPurpleColor,
                      ),
                    );
                  } else if(snapshot.hasData) {
                  var profiles=  askCubit.saveModelsData(snapshot.data!, profCubit.userDocId);
                    return OptionsListBlock(
                      lables: getAdminsLableList(
                          profileModels: profiles),
                      subValues:getUnreadMessagesNumberList(profileModels: profiles),
                      icons: List<IconData>.generate(
                        profiles.length,
                            (index) => Icons.person,
                        growable: true,
                      ),
                      onClickFunction: (index, context) async {
                        ContactMessageModel? model = profiles[index].contactMessageModel;
                        if (model == null) {
                          ContactMessageModel contact =
                          ContactMessageModel(
                            docId1: profCubit.userDocId,
                            docId2: profiles[index].docId,
                            senderAndReceiverDocId: profCubit.userDocId +
                                profiles[index].docId,
                            unReadMessagesNoDocId1: 0,
                            unReadMessagesNoDocId2: 1,
                            lastDate: DateTime.now(),
                            contactDocId: '',
                          );
                          model = await askCubit.createContact(
                              model: contact);
                          askCubit.editProfileModel(
                              index: index, model: model);
                        }

                        askCubit.receiveStreamMessages(
                            contactDocId: model.contactDocId);

                        if (model.docId1 == profCubit.userDocId) {
                          model.unReadMessagesNoDocId1 = 0;
                          await askCubit.setContactInformation(
                              model: profiles[index]
                                  .contactMessageModel!);
                        } else {
                          model.unReadMessagesNoDocId2 = 0;
                          await askCubit.setContactInformation(
                              model: profiles[index]
                                  .contactMessageModel!);
                        }

                        // Navigate to the chat screen
                        Get.to(ChatScreen(
                          contactModel: profiles[index].contactMessageModel!,
                          askCubit: askCubit,
                          profCubit: profCubit,
                          receiverModel: profiles[index],
                        ));
                      },
                    );
                  }
                  else{
                    return const Center(child: Text('No contacts found'));
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> getAdminsLableList({
    required List<ProfileModel> profileModels,
  }) {
    return profileModels.map((element) => element.nickName).toList();
  }

  List<String?> getUnreadMessagesNumberList({
    required List<ProfileModel> profileModels,
  }) {
    return profileModels
        .map((element) {
      if(element.contactMessageModel!=null) {
        return profCubit.userDocId != element.contactMessageModel!.docId1
            ? element.contactMessageModel!.unReadMessagesNoDocId2.toString()
            : element.contactMessageModel!.unReadMessagesNoDocId1.toString();
      }
      else {
        return null;
      }
    })
        .toList();
  }
}
