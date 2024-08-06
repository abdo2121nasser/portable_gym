import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portable_gym/resourses/services/bloc_observer/bloc_observer.dart';
import 'package:portable_gym/resourses/services/dio_service.dart';

import 'app_root/app_root.dart';
import 'firebase_options.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
 // DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);

  runApp(PortableGym());
}
