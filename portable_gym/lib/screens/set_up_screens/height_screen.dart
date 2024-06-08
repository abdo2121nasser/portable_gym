import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/weight_ruler_block.dart';
import '../../generated/l10n.dart';
import '../../resourses/blocks/age_picker_block.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/blocks/general_text_form_field.dart';
import '../../resourses/blocks/weight_type_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';
import 'goal_screen.dart';



class HeightScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leadingWidth: AppHorizontalSize.s100,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_left,
                color: ColorManager.kLimeGreenColor,
              ),
              Text(
                S.of(context).back,
                style: getSemiBoldStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.kLimeGreenColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),

            ],
          ),
        ),
        elevation: 0,
        backgroundColor: ColorManager.kBlackColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(S.of(context).whatsYourHeight,
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Text(
            S.of(context).welcomeDescription,
            style: getLightStyle(
                fontSize: FontSize.s14,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kLeagueSpartanFont),
            textAlign: TextAlign.center,
          ),

          //  WeightTypeBlock(),
          //WeightRulerBlock(),
          Container(
            width: MediaQuery.of(context).size.width,
            //   height: AppVerticalSize.s253,
            color: ColorManager.kLightPurpleColor,
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20,vertical: AppVerticalSize.s5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).enterYourHeight,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                SizedBox(
                  height: AppVerticalSize.s5,
                ),

                GeneralTextFormField(onlyInteger: true,),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),
              ],
            ),
          ),

          GeneralButtonBlock(
            lable: S.of(context).continued,
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GoalScreen(),));

            },
            backgroundColor: ColorManager.kBlackColor,
            textStyle: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
        ],
      ),
    );
  }
}
