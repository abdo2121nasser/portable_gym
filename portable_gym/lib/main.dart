import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/progress_models/activity_model.dart';
import 'package:my_coach/resourses/services/bloc_observer/bloc_observer.dart';
import 'app_root/app_root.dart';
import 'firebase_options.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
  Hive.registerAdapter(ActivityAdapter());
  await Hive.openBox(StringManager.activityBox);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);

  runApp(MyCoachApp());
}
//
// Future<void> initializeFirebaseMessaging() async {
//   // Handle FCM messages when the app is opened from a notification
//   print("\n");
//   print(await FirebaseMessaging.instance.getToken());
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print('App opened from a notification!');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('App has from a notification!');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
//
// }
// Future<void> backgroundHandler(RemoteMessage message)async {
//
//
// }
