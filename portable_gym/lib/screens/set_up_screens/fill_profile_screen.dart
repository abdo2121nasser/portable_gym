import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/blocks/weight_ruler_block.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../generated/l10n.dart';
import '../../resourses/blocks/age_picker_block.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/blocks/general_text_form_field.dart';
import '../../resourses/blocks/goal_choice_block.dart';
import '../../resourses/blocks/levels_block.dart';
import '../../resourses/blocks/profile_photo_block.dart';
import '../../resourses/blocks/weight_type_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';

class FillProfileScreen extends StatelessWidget {
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
          Text(S.of(context).fillYourProfile,
              style: getBoldStyle(
                  fontSize: FontSize.s24,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: AppVerticalSize.s18),
            child: Text(
              S.of(context).welcomeDescription,
              style: getLightStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s8),
            width: MediaQuery.of(context).size.width,
            height: AppVerticalSize.s150,
            color: ColorManager.kLightPurpleColor,
            child: ProfilePhotoBlock(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.3,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20,vertical: AppVerticalSize.s10),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(S.of(context).fullName,
                      style: getSemiBoldStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.kPurpleColor,
                          fontFamily: FontFamily.kPoppinsFont)),
                  SizedBox(height: AppVerticalSize.s5,),
                  GeneralTextFormField(),
                ],),
                separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s10,),
                itemCount: 4),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: AppVerticalSize.s14),
            child: GeneralButtonBlock(
              lable: S.of(context).start,
              function: () {},
              backgroundColor: ColorManager.kLimeGreenColor,
              textStyle: getMeduimStyle(
                  fontSize: FontSize.s24,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
            ),
          ),
        ],
      ),
    );
  }
}
