import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/square_element%20_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';


class GridSquareBlock extends StatelessWidget {
  const GridSquareBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22,vertical: AppVerticalSize.s14),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisExtent: 140,
            crossAxisSpacing:10,
            childAspectRatio: (1/.8),
            mainAxisSpacing: 15),
        itemBuilder: (context, index) => SquareElementBlock(),
        itemCount: 7,
      ),
    );
  }
}
