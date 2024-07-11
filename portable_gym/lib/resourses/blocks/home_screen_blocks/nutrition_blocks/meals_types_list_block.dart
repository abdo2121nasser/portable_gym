import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../general_blocks/horizontal_square_block.dart';

class MealsTypesListBlock extends StatelessWidget {
  final List<String> lables;

  MealsTypesListBlock({required this.lables});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
          itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lables[index],
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kLimeGreenColor,
                        fontFamily: FontFamily.kPoppinsFont),
                  ),
                  SizedBox(
                      height: AppVerticalSize.s160,
                      child: Row(
                        children: [
                          //HorizontalSquareBlock(),
                         //todo uncomment it when it ready to read payed recipes
                        ],
                      )),
                ],
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: AppVerticalSize.s5,
              ),
          itemCount: lables.length),
    );
  }
}
