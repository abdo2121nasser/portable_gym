import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/values_manager.dart';

class ProfilePhotoBlock extends StatelessWidget {
  final ImageProvider image;
  final bool isEditable;

  ProfilePhotoBlock({required this.image,this.isEditable=true});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:image
              )),
        ),
    isEditable?    Positioned(
          bottom: AppVerticalSize.s2,
          left: MediaQuery.of(context).size.width * 0.56,
          child: Container(
            padding: EdgeInsets.all(AppVerticalSize.s5),
            decoration: const BoxDecoration(
                color: ColorManager.kLimeGreenColor, shape: BoxShape.circle),
            child: Image.asset(ImageManager.kPenIconImage),
          ),
        )
        : SizedBox()
      ],
    );

  }
}
