import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/progress_models/activity_model.dart';
import 'package:portable_gym/resourses/services/bloc_observer/bloc_observer.dart';
import 'package:portable_gym/resourses/services/firebase_notification_service/notification_service.dart';
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
 await NotificationService.init();
 await initializeFirebaseMessaging();
// 'fnJiynhHThCWfsQs9QzwZ7:APA91bFptdHhpH5eGosIycReo6wreH5R84aoJffLHm36wm2B3uheIH1cBbxP7xYkn2bfXDDzwiDwrErdwZu722DRHhKHO01MbMcCo9RWwAVUpJMCJEAplq6wUbXRNUZ9PmOlFm7P-dz7');

  runApp(PortableGym());
}
//eFEeD0DdQKKryBE702Vdvc:APA91bHI0_Myf2erZ79NR00kARVG-AF1cYc-y0qs78_mQh1fdxj9kJle8Fz2Oncl31vc1Zq33xmgyNtxZBfYhZ_QFcwLeujV3E_ezM-l1rHQxa4j8Xxxq91_EMqBXrBZYtLXx0hE4Vuk

Future<void> initializeFirebaseMessaging() async {
  // Handle FCM messages when the app is opened from a notification
  print("\n");
  print(await FirebaseMessaging.instance.getToken());
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('App opened from a notification!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('App has from a notification!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

}
Future<void> backgroundHandler(RemoteMessage message)async {


}
