import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/services/firebase_notification_service/notification_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of(context);


  Future<void> sendNotification(
      {required String title, required String receiverDeviceToken,required String message}) async {
    try {

      await NotificationService.sendNotification(
         title: title,
          body: message,
          receiverDeviceToken: receiverDeviceToken);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
