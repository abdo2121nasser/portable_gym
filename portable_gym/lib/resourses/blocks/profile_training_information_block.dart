import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../managers_files/font_manager.dart';
import '../managers_files/style_manager.dart';




class ProfileTrainingInformationBlock extends StatelessWidget {
  const ProfileTrainingInformationBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorManager.kPurpleColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                '16 KG',
                style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
              Text(
                'Weight',
                style: getLightStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),


            ],
          ),
          SizedBox(
              height:MediaQuery.of(context).size.height*0.07,
              child: VerticalDivider(thickness: AppHorizontalSize.s2,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                '16 KG',
                style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
              Text(
                'years old',
                style: getLightStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),


            ],
          ),
          SizedBox(
              height:MediaQuery.of(context).size.height*0.07,
              child: VerticalDivider(thickness: AppHorizontalSize.s2,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                '16 KG',
                style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
              Text(
                'Weight',
                style: getLightStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),


            ],
          ),

        ],
      ),
    );
  }
}
