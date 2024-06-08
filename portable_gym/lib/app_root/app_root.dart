import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/managers_files/theme_manager.dart';
import 'package:portable_gym/screens/authentication_screens/forget_password.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';
import 'package:portable_gym/screens/set_up_screens/age_screen.dart';
import 'package:portable_gym/screens/set_up_screens/gender_screen.dart';
import 'package:portable_gym/screens/set_up_screens/weight_screen.dart';

import '../generated/l10n.dart';
import '../screens/authentication_screens/sign_up_screen.dart';
import '../screens/set_up_screens/activity_level_screen.dart';
import '../screens/set_up_screens/fill_profile_screen.dart';
import '../screens/set_up_screens/goal_screen.dart';
import '../screens/set_up_screens/height_screen.dart';



class PortableGym extends StatelessWidget {
      PortableGym.internalConstructor();
   static final PortableGym instance = PortableGym.internalConstructor();
      factory PortableGym() => instance;
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: true,
      builder: (context)=> SafeArea(
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          builder:(context, child) => MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: getAppTheme(),
      home: FillProfileScreen(),
      // home: ForgetPasswordScreen(),
       //  home: LoginScreen(),
       //  home: SignUpScreen(),
            ),
        ),
      ),
    );
  }
}
