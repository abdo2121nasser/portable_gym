import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_coach/resourses/managers_files/theme_manager.dart';
import 'package:my_coach/screens/splash_screen.dart';
import '../generated/l10n.dart';
import '../resourses/managers_files/string_manager.dart';

class MyCoachApp extends StatelessWidget {
  const MyCoachApp.internalConstructor({super.key});

  static const MyCoachApp instance = MyCoachApp.internalConstructor();

  factory MyCoachApp() => instance;

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) => SafeArea(
        child: ScreenUtilInit(
            designSize: const Size(393, 852),
            builder: (context, child) => FutureBuilder(
                future: getLocalLanguage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GetMaterialApp(
                      locale: Locale(snapshot.data!),
                      // locale: Locale('ar'),
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      debugShowCheckedModeBanner: false,
                      theme: getAppTheme(),
                      // home: SubscriptionPage(),
                      // home: MainNavigationBarScreen(),
                      //home: ProfileScreen(),

                      // home: FirebaseAuth.instance.currentUser == null
                      //      ? const LoginScreen()
                      //     :
                      // FirebaseAuth.instance.currentUser!.emailVerified ||true ?
                      // const MainNavigationBarScreen():const LoginScreen(),
                      //
                      home: SplashScreen(),
                      // home: AnswerQuestionsScreen(userNickName: '', collection: StringManager.collectionQuestionsOfProfile,
                      // finishProfileSetupFunction: (Map<String, dynamic> x){
                      //   Future.delayed(Duration(seconds: 6)).then((value) {
                      //     print('done');
                      //   });
                      // },
                      // ),
                      // home: SetUpScreen(email: 'email'),
                      // home: LoginScreen(),
                    );
                  } else {
                    return const SizedBox();
                  }
                })),
      ),
    );
  }

  Future<String> getLocalLanguage() async {
    return await const FlutterSecureStorage().read(
          key: StringManager.localLanguage,
        ) ??
        'en';
  }
}
// class NoSplashScrollBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }

//}
