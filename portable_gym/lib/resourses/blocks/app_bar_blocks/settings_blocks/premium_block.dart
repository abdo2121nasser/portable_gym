// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_coach/cubits/payment_cubit/payment_cubit.dart';
// import 'package:my_coach/resourses/managers_files/image_manager.dart';
// import 'package:my_coach/resourses/managers_files/values_manager.dart';
//
// import '../../../../generated/l10n.dart';
// import '../../../managers_files/color_manager.dart';
// import '../../../managers_files/font_manager.dart';
// import '../../../managers_files/style_manager.dart';
// import '../../../models/profile_models/profile_model.dart';
//
// class PremiumBlock extends StatelessWidget {
//   ProfileModel profileModel;
//
//   PremiumBlock({super.key, required this.profileModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PaymentCubit(profileModel: profileModel),
//       child: BlocConsumer<PaymentCubit, PaymentState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return state is InitRevenueCatWithApiLoadingState ||
//                   state is PresentPayWallLoadingState ||
//                   state is InitRevenueCatWithApiSuccessState
//               ? const SizedBox.shrink()
//               : Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: AppHorizontalSize.s30,
//                       vertical: AppVerticalSize.s5),
//                   child: InkWell(
//                     onTap: () {
//                       PaymentCubit.get(context).initRevenueCat(context);
//                     },
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           ImageManager.kCrownImage,
//                           width: AppHorizontalSize.s30,
//                         ),
//                         SizedBox(
//                           width: AppHorizontalSize.s22,
//                         ),
//                         Text(
//                           S.of(context).premium,
//                           style: getRegularStyle(
//                               fontSize: FontSize.s20,
//                               color: ColorManager.kWhiteColor,
//                               fontFamily: FontFamily.kLeagueSpartanFont),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }
