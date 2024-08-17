import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/ask_trainer_blocks/message_chat_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/ask_trainer_models/message_model.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';

class ChatScreen extends StatelessWidget {
  final AskTrainerCubit askCubit;
  final ProfileCubit profCubit;
  final ProfileModel receiverModel;
  final _scrollController = ScrollController();

  ChatScreen(
      {super.key,
      required this.askCubit,
      required this.profCubit,
      required this.receiverModel});

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
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    askCubit.messageStream == null
                        ? const Expanded(
                            child: Center(
                                child: CircularProgressIndicator(
                            color: ColorManager.kPurpleColor,
                          )))
                        : StreamBuilder(
                            stream: askCubit.messageStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<dynamic> messageModels =
                                    setMessageModels(snapshot);
                                return Expanded(
                                  child: ListView.separated(
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      return MessageChatBlock(
                                        message: messageModels[index].message,
                                        isSenderMessage:
                                            messageModels[index].senderDocId ==
                                                profCubit.userDocId,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: AppVerticalSize.s10,
                                    ),
                                    itemCount: messageModels.length,
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                    GeneralTextFormField(
                      controller: askCubit.messageController,
                      hint: S.of(context).hintMessage,
                      suffixIcon: Icon(
                        Icons.send,
                        color: ColorManager.kBlue,
                      ),
                      sendMessageFunction: () {
                        askCubit.sendMessage(
                            senderDocId: profCubit.userDocId,
                            senderAndReceiverDocId:
                                profCubit.userDocId + receiverModel.docId);
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  setMessageModels(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.data.docs
        .map((doc) =>
            MessageModel.fromJson(json: doc.data() as Map<String, dynamic>))
        .toList();
  }
}
