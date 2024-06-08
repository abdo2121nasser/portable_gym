import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/managers_files/theme_manager.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';
import 'package:portable_gym/screens/set_up_screens/gender_screen.dart';
import 'package:portable_gym/screens/set_up_screens/set_up_screen.dart';

import '../cubits/set_up_cubit/set_up_cubit.dart';
import '../generated/l10n.dart';
import '../screens/set_up_screens/age_screen.dart';


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
                  MaterialApp(
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
                    home: BlocProvider(
                      create: (context) => SetUpCubit(),
                      //todo fix this bloc brovider to its right place
                      child: SetUpScreen(),
                      //child: AgeScreen(),
                    ),
                    // home: ForgetPasswordScreen(),
                    //  home: LoginScreen(),
                    //  home: SignUpScreen(),
                  ),
            ),
          ),
    );
  }
}
