import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:my_coach/resourses/managers_files/secret_api_key_manager.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/managers_files/toast_massage_manager.dart';
import 'package:my_coach/resourses/models/profile_models/profile_model.dart';
import 'package:my_coach/screens/splash_screen.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.profileModel}) : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  final String entitlementString = 'Pro';
  ProfileModel profileModel;
  Future<void> initRevenueCat(
    context,
  ) async {
    try {
      emit(InitRevenueCatWithApiLoadingState());
      await Purchases.configure(
          PurchasesConfiguration(SecretApiKeyManager.reveneuCatPublicKey));
      emit(InitRevenueCatWithApiSuccessState());
      await _presentPayWall();
    } catch (error) {
      emit(InitRevenueCatWithApiErrorState());
      getToastMessage(message: S.of(context).somethingWentWrong,);
      debugPrint(error.toString());
    }
  }

  Future<void> _presentPayWall() async {
    try {
      emit(PresentPayWallLoadingState());
      await RevenueCatUI.presentPaywallIfNeeded(entitlementString);
      emit(PresentPayWallSuccessState());
      await _isProCustomer();
    } catch (error) {
      emit(PresentPayWallErrorState());
      debugPrint(error.toString());
    }
  }

  _isProCustomer() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      EntitlementInfo? entitlementInfo =
          customerInfo.entitlements.all[entitlementString];
      debugPrint(profileModel.isPremium.toString());
      debugPrint(entitlementInfo!.isActive.toString());
      if (!profileModel.isPremium && (entitlementInfo?.isActive ?? false)) {
        await _updateProfileExpireDate(info: entitlementInfo!);
      }
    });
  }

  _updateProfileExpireDate({required EntitlementInfo info}) async {
    emit(UpdateProfileExpireDateState());
    debugPrint('in updating profie expire date ------------------');
    DateTime dateTime = DateTime.parse(info.expirationDate!);
    // DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    // print(dateOnly);
    print(dateTime.toLocal());
    // print(dateTime);
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(profileModel.docId)
        .update({
      StringManager.userExpirationDate: Timestamp.fromDate(dateTime.toLocal()),
      StringManager.userIsPremium: true,
    }).then((onValue) {
      debugPrint('success--------------------');
      Get.offAll(() => const SplashScreen());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
