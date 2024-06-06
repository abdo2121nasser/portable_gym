import 'package:flutter/material.dart';



class PortableGym extends StatelessWidget {
      PortableGym.internalConstructor();
   static final PortableGym instance = PortableGym.internalConstructor();
      factory PortableGym() => instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    );
  }
}
