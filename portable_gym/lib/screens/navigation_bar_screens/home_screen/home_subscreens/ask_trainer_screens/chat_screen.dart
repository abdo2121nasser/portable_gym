import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/ask_trainer_blocks/message_chat_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).askTrainer,
        // TODO: Add the nickname of the trainer
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => MessageChatBlock(
                message: 'message $index',
                isAdminMessage: index % 2 == 0, // Example: alternating messages
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: AppVerticalSize.s5,
              ),
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}
