import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/blocks/general_text_form_field.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';
import 'age_screen.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

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
          Text(S.of(context).whatsYourGender,
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),

          Container(
            width: MediaQuery.of(context).size.width,
            //   height: AppVerticalSize.s253,
            color: ColorManager.kLightPurpleColor,
            padding: EdgeInsets.symmetric(
                horizontal: AppHorizontalSize.s5,
                vertical: AppVerticalSize.s10),
            child:  Text(
              S.of(context).welcomeDescription,
              style: getLightStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30,vertical: AppVerticalSize.s30),
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: AppHorizontalSize.s2,color: ColorManager.kWhiteColor)
            ),
            child: Image.asset(ImageManager.kMaleImage),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30,vertical: AppVerticalSize.s30),
            decoration: BoxDecoration(
              color: ColorManager.kLimeGreenColor,
            shape: BoxShape.circle,
            border: Border.all(width: AppHorizontalSize.s2,color: ColorManager.kLimeGreenColor)
            ),
            child: Image.asset(ImageManager.kFemaleImage,),
          ),
          GeneralButtonBlock(
            lable: S.of(context).continued,
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AgeScreen(),));

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
