import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/auth_cubit/authentication_cubit.dart';
import 'package:my_coach/cubits/set_up_cubit/set_up_cubit.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/image_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/full_input_block.dart';
import '../../general_blocks/profile_photo_block.dart';


class FillProfileSetUpBlock extends StatelessWidget {
  final SetUpCubit setCubit;

  const FillProfileSetUpBlock({super.key, required this.setCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: setCubit,
  child: BlocConsumer<SetUpCubit, SetUpState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.2,
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
              Expanded(
                child: ListView.separated(
                shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppHorizontalSize.s20,
                        vertical: AppVerticalSize.s10),
                    itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FullInputBlock(
                              lable: setCubit.getFillProfileInputsLables(
                                  context: context)[index],
                              color: ColorManager.kPurpleColor,
                              controller: setCubit.getFillProfileInputControllers(
                                  context: context)[index],
                              readOnly: index==2,
                              onlyInteger: index==3,
                              isNormalInput: true,


                            ),
                          ],
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: AppVerticalSize.s10,
                        ),
                    itemCount: setCubit.getFillProfileInputsLables(
                        context: context).length),
              ),
            ],
          ),
        );
      },
    ),
);
  }
}
