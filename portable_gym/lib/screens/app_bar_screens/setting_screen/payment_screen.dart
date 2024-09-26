import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/payment_cubit/payment_cubit.dart';
import 'package:my_coach/resourses/blocks/general_blocks/option_list_block.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../resourses/managers_files/color_manager.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    super.initState();
    PaymentCubit.get(context).initRevenueCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S
            .of(context)
            .subscriptiosWord,
        backgroundColor: ColorManager.kLightPurpleColor,
        titleColor: ColorManager.kWhiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s22,),
        child: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            var payCubit=PaymentCubit.get(context);
            return
              state is InitRevenueCatWithApiState ||
              state is FetchAvailableOffersLoadingState

              ?
              const Center(
                child: CircularProgressIndicator(color: ColorManager.kPurpleColor,),
              ):
              OptionsListBlock(
              lables: ['firrst'],
              icons: [Icons.local_offer],
              onClickFunction: (int, BuildContext) {},
            );
          },
        ),
      ),
    );
  }
}
