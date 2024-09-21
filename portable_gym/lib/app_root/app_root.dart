import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/theme_manager.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/main_navigation_bar_screen.dart';
import 'package:portable_gym/screens/splash_screen.dart';


import '../generated/l10n.dart';
import '../resourses/managers_files/string_manager.dart';
import '../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/answer_questions_screen.dart';
import '../screens/set_up_screen.dart';


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
                       FutureBuilder(
                         future: getLocalLanguage(),
                         builder: (context,snapshot) {
                             if(snapshot.hasData ){
                               return    GetMaterialApp(
                                 locale:  Locale(snapshot.data!),
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
                             }
                             else{
                               return const SizedBox();
                             }

                         }
                       )

            ),
          ),
    );
  }
 Future<String> getLocalLanguage()
  async {
   return await const FlutterSecureStorage()
        .read(key: StringManager.localLanguage,)??'en';
  }
}
// class NoSplashScrollBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }

//}