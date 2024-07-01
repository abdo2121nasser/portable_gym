import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../../../generated/l10n.dart';



class PeriodPickerBlock extends StatelessWidget {

    final bool isTrainingDate;

    PeriodPickerBlock({this.isTrainingDate=true});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOutCubit, WorkOutState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var workCubit=WorkOutCubit.get(context);
    return Column(
      children: [
        Text(S.of(context).trainingTime,style: getSemiBoldStyle(fontSize: FontSize.s22, color: ColorManager.kBlackColor, fontFamily: FontFamily.kPoppinsFont),),
        Container(
          alignment: Alignment.center,
          height: AppVerticalSize.s160,
          width: AppHorizontalSize.s250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusSize.s20),
            border: Border.all(color: ColorManager.kBlackColor,width: AppHorizontalSize.s3)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).hour,style: getSemiBoldStyle(fontSize: FontSize.s22, color: ColorManager.kBlackColor, fontFamily: FontFamily.kPoppinsFont),),
                 const SizedBox(width: 47,),
                  Text(S.of(context).minute,style: getSemiBoldStyle(fontSize: FontSize.s22, color: ColorManager.kBlackColor, fontFamily: FontFamily.kPoppinsFont),),
                  const SizedBox(width: 47,),
                  Text(S.of(context).second,style: getSemiBoldStyle(fontSize: FontSize.s22, color: ColorManager.kBlackColor, fontFamily: FontFamily.kPoppinsFont),)
                ],
              ),
              TimePickerSpinner(
                alignment: Alignment.center,
                locale: Localizations.localeOf(context),
                time: isTrainingDate? workCubit.trainingPeriod:workCubit.bodyCategoryTotalTime,
                isShowSeconds: true,
                itemHeight: AppVerticalSize.s30,
                normalTextStyle:  TextStyle(
                  fontSize: FontSize.s22,
                ),
                highlightedTextStyle:
                 TextStyle(fontSize: FontSize.s22, color: Colors.blue),
                isForce2Digits: true,
                onTimeChange: (time) {
                 if(isTrainingDate) {
                   workCubit.setTrainingPeriod(date: time);
                 } else
                   {
                     workCubit.setBodyCategoryTotalTime(date: time);
                   }
                },
              ),
            ],
          ),
        ),
      ],
    );
  },
);
  }

}
