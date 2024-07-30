import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/authentication_screens/login_screen.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';

class LogOutBottomSheetBlock extends StatelessWidget {
  const LogOutBottomSheetBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          color: ColorManager.kLightPurpleColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadiusSize.s22),
              topRight: Radius.circular(AppRadiusSize.s22))),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).logOutMassage,
            style: getMediumStyle(
                fontSize: FontSize.s20,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kLeagueSpartanFont),
          ),
     Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         GeneralButtonBlock(
             lable: S.of(context).cancel,
             function: (){
               Get.back();
             },
             backgroundColor: ColorManager.kWhiteColor,
             textStyle: getMediumStyle(
                 fontSize: FontSize.s20,
                 color: ColorManager.kPurpleColor,
                 fontFamily: FontFamily.kLeagueSpartanFont)),
         GeneralButtonBlock(
             lable: S.of(context).logout,
             function: (){
               logOut(context);
             },
             backgroundColor: ColorManager.kLimeGreenColor,
             textStyle: getMediumStyle(
                 fontSize: FontSize.s20,
                 color: ColorManager.kBlackColor,
                 fontFamily: FontFamily.kLeagueSpartanFont)),

       ],
     )
        ],
      ),
    );
  }
  logOut(context) async {

    await FirebaseAuth.instance.signOut().then((value) {
      getToastMessage(message: S.of(context).success);

      Get.offAll(LoginScreen());
    }).catchError((error){
      getToastMessage(message: S.of(context).somethingWentWrong);
      debugPrint(error);
    });
  }
}
