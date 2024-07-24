import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/progress_tracking_cubit/progress_tracking_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/theme_manager.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/nutraition_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/main_navigation_bar_screen.dart';

import 'package:portable_gym/screens/set_up_screen.dart';

import '../cubits/set_up_cubit/set_up_cubit.dart';
import '../generated/l10n.dart';


class PortableGym extends StatelessWidget {
  PortableGym.internalConstructor();

  static final PortableGym instance = PortableGym.internalConstructor();

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
                    locale: const Locale('en'),
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
                    home: LoginScreen(),
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