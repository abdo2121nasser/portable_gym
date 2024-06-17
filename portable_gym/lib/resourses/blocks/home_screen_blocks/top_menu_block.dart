import 'package:flutter/material.dart';
import 'package:portable_gym/cubits/home_cubit/home_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/top_menu_element_block.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/values_manager.dart';




class TopMenuBlock extends StatelessWidget {
  const TopMenuBlock({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit=HomeCubit.get(context);
    return  SizedBox(
      height: AppVerticalSize.s120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    vertical: AppVerticalSize.s12,
                    horizontal: AppHorizontalSize.s22),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    TopMenuElementBlock(
                      lable: homeCubit.getTopMenuLables(
                          context: context, index: index),
                      image:
                      homeCubit.getTopMenuImages(index: index),
                    ),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppHorizontalSize.s22),
                  child: VerticalDivider(
                    color: ColorManager.kLightPurpleColor,
                    thickness: AppHorizontalSize.s1_5,
                    endIndent: AppVerticalSize.s12,
                    indent: AppVerticalSize.s12,
                  ),
                ),
                itemCount: 4),
          ),
          // Spacer(flex: 1,)
        ],
      ),
    );
  }
}
