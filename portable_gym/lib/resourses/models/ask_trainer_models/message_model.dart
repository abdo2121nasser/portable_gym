import 'package:cloud_firestore/cloud_firestore.dart';

import '../../managers_files/string_manager.dart';

class MessageModel {
  final String message;
  final String fileLink;
  final String senderDocId;
  final String senderAndReceiverDocId;
  final DateTime messageDate;

  MessageModel({
    required this.message,
    required this.fileLink,
    required this.senderDocId,
    required this.senderAndReceiverDocId,
    required this.messageDate,
  });

  // Factory constructor to create a ChatMessage from a Firestore document
  factory MessageModel.fromJson({required Map<String, dynamic> json}) {
    return MessageModel(
      message: json[StringManager.message] ?? '',
      fileLink: json[StringManager.fileLink] ?? '',
      senderDocId: json[StringManager.senderDocId] ?? '',
      senderAndReceiverDocId: json[StringManager.senderAndReceiverDocId] ?? '',
      messageDate: (json[StringManager.messageDate] as Timestamp).toDate(),
    );
  }

  // Method to convert ChatMessage to a map for sending to Firestore
  Map<String, dynamic> toJson() {
    return {
      StringManager.message: message,
      StringManager.fileLink:fileLink,
      StringManager.senderDocId: senderDocId,
      StringManager.senderAndReceiverDocId: senderAndReceiverDocId,
      StringManager.messageDate: Timestamp.fromDate(messageDate),
    };
  }
}
