import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class PortableGym extends StatelessWidget {
      PortableGym.internalConstructor();
   static final PortableGym instance = PortableGym.internalConstructor();
      factory PortableGym() => instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder:(context, child) => MaterialApp(

        ),
    );
  }
}
