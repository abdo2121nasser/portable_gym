import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import '../full_input_block.dart';
import '../gender_block.dart';
import '../general_text_form_field.dart';
import '../profile_photo_block.dart';

class FillProfileSetUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetUpCubit, SetUpState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var setCubit = SetUpCubit.get(context);
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s8),
              width: MediaQuery.of(context).size.width,
              height: AppVerticalSize.s150,
              color: ColorManager.kLightPurpleColor,
              child: InkWell(
                  onTap: () async {
                    await setCubit.pickImage();
                  },
                  child: ProfilePhotoBlock(
                    image: setCubit.imageFile == null
                        ? Image.asset(ImageManager.kSmileManImage).image
                        : Image.file(File(setCubit.imageFile!.path)).image,
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppHorizontalSize.s20,
                      vertical: AppVerticalSize.s10),
                  itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FullInputBlock(
                            lable: setCubit.getFillProfileInputsLables(
                                context: context, index: index),
                            color: ColorManager.kPurpleColor,
                            controller: setCubit.getFillProfileInputControllers(
                                context: context, index: index),
                          ),
                        ],
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppVerticalSize.s10,
                      ),
                  itemCount: 4),
            ),
          ],
        );
      },
    );
  }
}
