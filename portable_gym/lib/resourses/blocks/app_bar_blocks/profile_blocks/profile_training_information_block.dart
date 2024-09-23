import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';




class ProfileTrainingInformationBlock extends StatelessWidget {
               final int age;
               final int weight;
               final int height;

               ProfileTrainingInformationBlock({required this.age,required  this.weight,
               required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s14),
    width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorManager.kPurpleColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
              weight.toString(),
                style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
              Text(
                S.of(context).weight,
                style: getLightStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),


            ],
          ),
          SizedBox(
              height:MediaQuery.of(context).size.height*0.05,
              child: VerticalDivider(thickness: AppHorizontalSize.s2,color: ColorManager.kWhiteColor,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                age.toString(),
                style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
              Text(
                S.of(context).yearsOld,
                style: getLightStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),


            ],
          ),
          SizedBox(
              height:MediaQuery.of(context).size.height*0.05,
              child: VerticalDivider(thickness: AppHorizontalSize.s2,color: ColorManager.kWhiteColor,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                height.toString(),
                style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kLeagueSpartanFont),
              ),
              Text(
                S.of(context).height,
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
