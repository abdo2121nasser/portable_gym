import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

class ContactMessageModel {
  final String contactDocId;
  final String docId1;
  final String docId2;
  final String senderAndReceiverDocId;
  final int unReadMessagesNoDocId1;
  final int unReadMessagesNoDocId2;
  final DateTime lastDateDocId1Sent;
  final DateTime lastDateDocId2Sent;

  ContactMessageModel(
      {required this.docId1,
      required this.docId2,
      required this.senderAndReceiverDocId,
      required this.unReadMessagesNoDocId1,
      required this.unReadMessagesNoDocId2,
      required this.lastDateDocId1Sent,
      required this.lastDateDocId2Sent,
      required this.contactDocId});

  factory ContactMessageModel.fromJson(
      {required Map<String, dynamic> json, required String contactDocId}) {
    return ContactMessageModel(
        docId1: json[StringManager.contactDocId1],
        docId2: json[StringManager.contactDocId2],
        senderAndReceiverDocId: json[StringManager.senderAndReceiverDocId],
        unReadMessagesNoDocId1: json[StringManager.unReadDocId1MessageNo],
        unReadMessagesNoDocId2: json[StringManager.unReadDocId2MessageNo],
        lastDateDocId1Sent:
            (json[StringManager.lastDateDocId1Sent] as Timestamp).toDate(),
        lastDateDocId2Sent:
            (json[StringManager.lastDateDocId2Sent] as Timestamp).toDate(),
        contactDocId: contactDocId);
  }

  Map<String, dynamic> toJson() {
    return {
      StringManager.contactDocId1: docId1,
      StringManager.contactDocId2: docId2,
      StringManager.senderAndReceiverDocId: senderAndReceiverDocId,
      StringManager.unReadDocId1MessageNo: unReadMessagesNoDocId1,
      StringManager.unReadDocId2MessageNo: unReadMessagesNoDocId2,
      StringManager.lastDateDocId1Sent: Timestamp.fromDate(lastDateDocId1Sent),
      StringManager.lastDateDocId2Sent: Timestamp.fromDate(lastDateDocId2Sent),
    };
  }
}
