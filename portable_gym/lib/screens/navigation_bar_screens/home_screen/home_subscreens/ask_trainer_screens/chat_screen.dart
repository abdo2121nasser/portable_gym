import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/ask_trainer_cubit/ask_trainer_cubit.dart';
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
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/ask_trainer_blocks/message_stream_builder_block.dart';

class ChatScreen extends StatefulWidget {
  final AskTrainerCubit askCubit;
  final ProfileCubit profCubit;
  final ProfileModel receiverModel;
  final ContactMessageModel contactModel;

  const ChatScreen(
      {super.key,
        required this.contactModel,
      required this.askCubit,
      required this.profCubit,
      required this.receiverModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.profCubit,
      child: BlocProvider.value(
        value: widget.askCubit,
        child: BlocConsumer<AskTrainerCubit, AskTrainerState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: GeneralAppBarBlock(
                title: widget.receiverModel.nickName,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    getChatBody,
                    getFileBoxBlock(state),
                    LinearProgressIndicatorBlock(
                        isLoading: state is UploadFileLoadingState||
                            state is DownloadFileLoadingState
                    ),
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
      controller: widget.askCubit.messageController,
      hint: S.of(context).hintMessage,
      suffixIcon: Icon(
        Icons.send,
        color: state is UploadFileLoadingState
            ? ColorManager.kBlackColor
            : ColorManager.kBlue,
      ),
      sendMessageFunction: state is UploadFileLoadingState
          ? null
          : () {

              sendMessage();
            },
      prefixIcon: state is UploadFileLoadingState
          ? null
          : const Icon(
              Icons.attach_file,
              color: ColorManager.kBlackColor,
            ),
      selectFileFunction: () {
        widget.askCubit.pickFile();
      },
    );
  }

  Widget getFileBoxBlock(AskTrainerState state) {
    return widget.askCubit.messageFile != null
        ? FileBoxBlock(
            hasSuffixIcon: state is! UploadFileLoadingState,
            suffixIconFunction: () {
              widget.askCubit.removeFileFromSendingState();
            },
          )
        : const SizedBox();
  }

  Widget get getChatBody {
    return widget.askCubit.messageStream == null
        ? const Expanded(
            child: Center(
                child: CircularProgressIndicator(
            color: ColorManager.kPurpleColor,
          )))
        : MessageStreamBuilderBlock(
            scrollController: _scrollController,
          );
  }

  void sendMessage() {
    widget.askCubit.sendMessageProcess(
      receiverDocId:widget.receiverModel.docId,
        senderDocId: widget.profCubit.userDocId,
      contactModel: widget.contactModel

);
   // getToLastMessage();
  }

  void getToLastMessage() {
    _scrollController.animateTo(
        //_scrollController.position.maxScrollExtent,
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear);
  }

  setMessageModels(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.data.docs
        .map((doc) =>
            MessageModel.fromJson(json: doc.data() as Map<String, dynamic>))
        .toList();
  }
}
