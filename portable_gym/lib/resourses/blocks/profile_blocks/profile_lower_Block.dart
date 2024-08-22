import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';
import '../general_blocks/full_input_block.dart';
import '../general_blocks/general_button_block.dart';

class ProfileLowerBlock extends StatefulWidget {
  final ProfileModel profileModel;

  const ProfileLowerBlock({super.key, required this.profileModel});

  @override
  State<ProfileLowerBlock> createState() => _ProfileLowerBlockState();
}

class _ProfileLowerBlockState extends State<ProfileLowerBlock> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context)
        .setProfileControllers(profileModel: widget.profileModel);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var profCubit = ProfileCubit.get(context);
        var controllers = profCubit.getProfileControllers();
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.only(
                        right: AppHorizontalSize.s22,
                        left: AppHorizontalSize.s22,
                        bottom: AppVerticalSize.s20),
                    itemBuilder: (context, index) {
                      return index != controllers.length
                          ? FullInputBlock(
                              lable: profCubit.getProfileInputsLables(
                                  context: context)[index],
                              color: ColorManager.kPurpleColor,
                              controller:
                                  profCubit.getProfileControllers()[index],
                              isNormalInput: true,
                              onlyInteger: index > 3,
                              readOnly: profCubit.profileModel!.docId ==
                                      widget.profileModel.docId
                                  ? index == 2
                                  : true,
                            )
                          : state is UpdateUserDataLoadingState ||
                                  state is DeleteImageFileOnCloudLoadingState ||
                                  state is DeleteImageFileOnCloudSuccessState ||
                                  state is UploadImageFileLoadingState ||
                                  state is UploadImageFileSuccessState
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: ColorManager.kPurpleColor,
                                  ),
                                ))
                              : profCubit.profileModel!.docId ==
                                      widget.profileModel.docId
                                  ? GeneralButtonBlock(
                                      lable: S.of(context).edit,
                                      function: () {
                                        profCubit.editUserData();
                                      },
                                      backgroundColor:
                                          ColorManager.kPurpleColor,
                                      textStyle: getMediumStyle(
                                          fontSize: FontSize.s20,
                                          color: ColorManager.kWhiteColor,
                                          fontFamily: FontFamily.kPoppinsFont))
                                  : const SizedBox();
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: AppVerticalSize.s5,
                        ),
                    itemCount: profCubit.profileModel!.docId ==
                            widget.profileModel.docId
                        ? controllers.length + 1
                        : controllers.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
