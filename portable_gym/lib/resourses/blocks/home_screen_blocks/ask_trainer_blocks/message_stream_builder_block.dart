import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';

import '../../../managers_files/values_manager.dart';
import '../../../models/ask_trainer_models/message_model.dart';
import 'message_chat_block.dart';


class MessageStreamBuilderBlock extends StatelessWidget {
  final ScrollController scrollController;

   const MessageStreamBuilderBlock({super.key,required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AskTrainerCubit, AskTrainerState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var askCubit=AskTrainerCubit.get(context);
        var profCubit=ProfileCubit.get(context);
        return StreamBuilder(
          stream: askCubit.messageStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> messageModels =
              setMessageModels(snapshot);
              return Expanded(
                child: ListView.separated(
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s8),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return MessageChatBlock(
                      fileLink: messageModels[index].fileLink,
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
        );
      },
    );
  }
  setMessageModels(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.data.docs
        .map((doc) =>
        MessageModel.fromJson(json: doc.data() as Map<String, dynamic>))
        .toList();
  }
}
