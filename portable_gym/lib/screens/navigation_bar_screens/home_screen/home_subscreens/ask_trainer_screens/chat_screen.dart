import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/ask_trainer_blocks/file_box_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/ask_trainer_blocks/linear_progress_indicator_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/ask_trainer_blocks/message_chat_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/ask_trainer_models/contact_message_model.dart';
import 'package:portable_gym/resourses/models/ask_trainer_models/message_model.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';
import 'package:portable_gym/screens/app_bar_screens/profile_screen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/ask_trainer_blocks/message_stream_builder_block.dart';

class ChatScreen extends StatelessWidget {
  final AskTrainerCubit askCubit;
  final ProfileCubit profCubit;
  final ProfileModel receiverModel;
  ContactMessageModel contactModel;

  ChatScreen(
      {super.key,
      required this.contactModel,
      required this.askCubit,
      required this.profCubit,
      required this.receiverModel});

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profCubit,
      child: BlocProvider.value(
        value: askCubit,
        child: BlocConsumer<AskTrainerCubit, AskTrainerState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: GeneralAppBarBlock(
                title: receiverModel.nickName,
                titleColor: ColorManager.kPurpleColor,
                titleFunction: () async {
                  Get.back();
                  contactModel =
                      askCubit.setContactAttributes(profile: receiverModel);
                  if (contactModel.docId1 == profCubit.userDocId) {
                    if (contactModel.unReadMessagesNoDocId1 != 0) {
                      contactModel.unReadMessagesNoDocId1 = 0;
                      askCubit.updateUnreadedContact(
                          model: contactModel, isDocId1: true);
                    }
                  } else {
                    if (contactModel.unReadMessagesNoDocId2 != 0) {
                      contactModel.unReadMessagesNoDocId2 = 0;
                      askCubit.updateUnreadedContact(
                          model: contactModel, isDocId1: false);
                    }
                  }
                },
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(ProfileScreen(
                            profileModel: receiverModel,
                            profCubit: profCubit,
                          isMyProfileScreen: false,

                        )

                        );
                      },
                      icon: const Icon(
                        Icons.person,
                        color: ColorManager.kPurpleColor,
                      ))
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    getChatBody,
                    getFileBoxBlock(state),
                    LinearProgressIndicatorBlock(
                        isLoading: state is UploadFileLoadingState ||
                            state is DownloadFileLoadingState),
                    buildGeneralTextFormField(context, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  GeneralTextFormField buildGeneralTextFormField(
      BuildContext context, AskTrainerState state) {
    return GeneralTextFormField(
      controller: askCubit.messageController,
      hint: S.of(context).hintMessage,
      multiLine: true,
      suffixIcon: Icon(
        Icons.send,
        color: state is UploadFileLoadingState
            ? ColorManager.kBlackColor
            : ColorManager.kBlue,
      ),
      sendMessageFunction: state is UploadFileLoadingState
          ? null
          : () {
              if (askCubit.messageController.text.isNotEmpty ||
                  askCubit.messageFile != null) {
                sendMessage();
              }
            },
      prefixIcon: state is UploadFileLoadingState
          ? null
          : const Icon(
              Icons.attach_file,
              color: ColorManager.kBlackColor,
            ),
      selectFileFunction: () {
        askCubit.pickFile();
      },
    );
  }

  Widget getFileBoxBlock(AskTrainerState state) {
    return askCubit.messageFile != null
        ? FileBoxBlock(
            hasSuffixIcon: state is! UploadFileLoadingState,
            isChatFile: false,
            suffixIconFunction: () {
              askCubit.removeFileFromSendingState();
            },
            fileName: askCubit.fileName!,
          )
        : const SizedBox();
  }

  Widget get getChatBody {
    return askCubit.messageStream == null
        ? const Expanded(
            child: Center(
                child: CircularProgressIndicator(
            color: ColorManager.kPurpleColor,
          )))
        : MessageStreamBuilderBlock(
            scrollController: _scrollController,
          );
  }

  Future<void> sendMessage() async {
    contactModel = askCubit.setContactAttributes(profile: receiverModel);
    await askCubit.sendMessageProcess(
        receiverDocId: receiverModel.docId,
        senderDocId: profCubit.userDocId,
        contactModel: updateContactModel(model: contactModel),
        isDocId1: contactModel.docId1 != profCubit.userDocId);
    getToLastMessage();
  }

  ContactMessageModel updateContactModel({required ContactMessageModel model}) {
    model.lastDate = DateTime.now();
    if (model.docId1 == profCubit.userDocId) {
      model.unReadMessagesNoDocId2++;
    } else {
      model.unReadMessagesNoDocId1++;
    }
    return model;
  }

  void getToLastMessage() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  setMessageModels(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.data.docs
        .map((doc) =>
            MessageModel.fromJson(json: doc.data() as Map<String, dynamic>))
        .toList();
  }
}
