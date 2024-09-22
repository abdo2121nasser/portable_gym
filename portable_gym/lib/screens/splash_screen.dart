import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';

import 'authentication_screens/login_screen.dart';
import 'navigation_bar_screens/main_navigation_bar_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offAll(() => const LoginScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 1200));
      } else {
        if (FirebaseAuth.instance.currentUser!.emailVerified
            ||true
        )  {
           //todo delete the or true

          Get.offAll(() => const MainNavigationBarScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 1200));
        } else {
          Get.offAll(() => const LoginScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 1200));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.kBlackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4,
              child:Image.asset(
                ImageManager.kLogoImage,
              )),
          const CircularProgressIndicator(
            color: ColorManager.kPurpleColor,
          )
        ],
      ),
    );
  }
}
