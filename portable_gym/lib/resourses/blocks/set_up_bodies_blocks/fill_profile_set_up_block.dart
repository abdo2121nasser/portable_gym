import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import '../gender_block.dart';
import '../general_text_form_field.dart';
import '../profile_photo_block.dart';





class FillProfileSetUpBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
         Column(
           children: [
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

           ],
         )
    ;
  }
}
