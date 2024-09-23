import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/home_cubit/home_cubit.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/top_menu_element_block.dart';
import 'package:my_coach/resourses/managers_files/image_manager.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/values_manager.dart';




class TopMenuBlock extends StatelessWidget {
  const TopMenuBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var homeCubit=HomeCubit.get(context);
    var profCubit=ProfileCubit.get(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            vertical: AppVerticalSize.s12,
            horizontal: AppHorizontalSize.s22),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisExtent: 140,
            crossAxisSpacing: MediaQuery.of(context).size.width*0.1,
            childAspectRatio: (0.3 / 0.3),
            mainAxisSpacing: MediaQuery.of(context).size.height*0.1),
        itemBuilder: (context, index) =>
            InkWell(
              onTap: (){
                  homeCubit.navigateToTopMenuScreens(index: index,profCubit: ProfileCubit.get(context));

              },
              child: TopMenuElementBlock(
                lable: homeCubit.getTopMenuLables(
                    context: context, index: index),
                image: profCubit.profileModel==null?
                    ImageManager.kLockImage:
                (profCubit.profileModel!.isPremium || profCubit.profileModel!.isClient==false) && index>1?
                    homeCubit.getTopMenuImages(index: index):
                    index<2?homeCubit.getTopMenuImages(index: index): ImageManager.kLockImage

              ),
            ),
        itemCount: 4);
  },
) ;
  }
}

// SizedBox(
// height: MediaQuery.of(context).size.height*0.13,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Expanded(
// child: GridView.builder(
// padding: EdgeInsets.symmetric(
// vertical: AppVerticalSize.s12,
// horizontal: AppHorizontalSize.s22),
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// // mainAxisExtent: 140,
// crossAxisSpacing: 0,
// childAspectRatio: (1.0 / 0.3),
// mainAxisSpacing: 15),
// itemBuilder: (context, index) =>
// InkWell(
// onTap: (){
// homeCubit.navigateToTopMenuScreens(index: index,profCubit: ProfileCubit.get(context));
// },
// child: TopMenuElementBlock(
// lable: homeCubit.getTopMenuLables(
// context: context, index: index),
// image:
// homeCubit.getTopMenuImages(index: index),
// ),
// ),
// // separatorBuilder: (context, index) => Padding(
// //   padding: EdgeInsets.symmetric(
// //       horizontal: MediaQuery.of(context).size.width*0.045),
// //   child: VerticalDivider(
// //     color: ColorManager.kLightPurpleColor,
// //     thickness: AppHorizontalSize.s1_5,
// //     endIndent: AppVerticalSize.s12,
// //     indent: AppVerticalSize.s12,
// //   ),
// // ),
// itemCount: 4),
// ),
// // Spacer(flex: 1,)
// ],
// ),
// )
