import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/set_up_cubit/set_up_cubit.dart';
import 'package:my_coach/cubits/set_up_cubit/set_up_cubit.dart';


import '../../../managers_files/enum_manager.dart';
import '../../../managers_files/image_manager.dart';
import '../set_up_blocks/gender_block.dart';

class GenderSetUpBlock extends StatelessWidget {
  const GenderSetUpBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetUpCubit, SetUpState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var setCubit = SetUpCubit.get(context);
        return SizedBox(
            child: Column(
          children: [
            InkWell(
                onTap: () {
                  setCubit.changeGender(gender: Gender.male);
                },
                child: GenderBlock(
                  image: ImageManager.kMaleImage,
                  isChosed: setCubit.gender == Gender.male,
                )),
            InkWell(
                onTap: () {
                  setCubit.changeGender(gender: Gender.female);
                },
                child: GenderBlock(
                  image: ImageManager.kFemaleImage,
                  isChosed: setCubit.gender == Gender.female,
                )),
          ],
        ));
      },
    );
  }
}
