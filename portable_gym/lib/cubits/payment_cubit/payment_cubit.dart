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
      getToastMessage(message: S.of(context).somethingWentWrong);
      debugPrint(error.toString());
    }
  }

  Future<void> _presentPayWall() async {
    try {
      emit(PresentPayWallLoadingState());
      await RevenueCatUI.presentPaywallIfNeeded(entitlementString);
      emit(PresentPayWallSuccessState());
      isProCustomer();
    } catch (error) {
      emit(PresentPayWallErrorState());
      debugPrint(error.toString());
    }
  }

  isProCustomer() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      EntitlementInfo? entitlementInfo =
          customerInfo.entitlements.all[entitlementString];
      print(entitlementInfo!.expirationDate);
      print(entitlementInfo!.store.toString());
      print(entitlementInfo!.unsubscribeDetectedAt);
      print(entitlementInfo!.toJson());
      if (   !profileModel.isPremium  &&  (entitlementInfo?.isActive ?? false)) {
        updateProfileExpireDateProcess( info: entitlementInfo!);
      }
    });
  }

  updateProfileExpireDateProcess({required EntitlementInfo info}) async {
    profileModel.isPremium = true;

    DateTime dateTime = DateTime.parse(info.expirationDate!);
    DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    profileModel.expireDate = dateOnly;
print(DateFormat('d/M/yyyy').format(dateOnly));
    await FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(profileModel.docId)
        .update({
      StringManager.userExpirationDate: Timestamp.fromDate(dateOnly),
      StringManager.userIsPremium: true,
    }).then((onValue) {
      Get.offAll(const SplashScreen());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
