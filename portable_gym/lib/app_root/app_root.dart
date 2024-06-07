import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/managers_files/theme_manager.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';



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
            debugShowCheckedModeBanner: false,
            theme: getAppTheme(),
         home: LoginScreen(),
            ),
        ),
      ),
    );
  }
}
