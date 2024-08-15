import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:portable_gym/cubits/language_cubit/language_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/theme_manager.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/nutraition_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/main_navigation_bar_screen.dart';

import 'package:portable_gym/screens/set_up_screen.dart';

import '../cubits/main_navigation_bar_cubit/main_navigation_bar_cubit.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../cubits/set_up_cubit/set_up_cubit.dart';
import '../generated/l10n.dart';


class PortableGym extends StatelessWidget {
  const PortableGym.internalConstructor({super.key});

  static const PortableGym instance = PortableGym.internalConstructor();

  factory PortableGym() => instance;

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: true,
      builder: (context) =>
          SafeArea(
            child: ScreenUtilInit(
              designSize: const Size(393, 852),
              builder: (context, child) =>
                  GetMaterialApp(
                    locale:const Locale('en'),
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    theme: getAppTheme(),
                    // home: MainNavigationBarScreen(),
                    //home: ProfileScreen(),

                    home: FirebaseAuth.instance.currentUser == null
                        ? const LoginScreen()
                        : const MainNavigationBarScreen(),
                    //   home: SetUpScreen(email: 'email'),
                    // home: LoginScreen(),
                  ),
            ),
          ),
    );
  }
}
// class NoSplashScrollBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }

//}