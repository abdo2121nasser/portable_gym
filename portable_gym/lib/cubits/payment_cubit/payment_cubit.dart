import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_coach/resourses/managers_files/secret_api_key_manager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  List<Package> availablePackages = [];

  Future<void> initRevenueCat() async {
    emit(InitRevenueCatWithApiState());
    await Purchases.configure(
        PurchasesConfiguration(SecretApiKeyManager.reveneuCatPublicKey));
    try {
      emit(FetchAvailableOffersLoadingState());
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        availablePackages = offerings.current!.availablePackages;
      }
      emit(FetchAvailableOffersSuccessState());
    } catch (e) {
      emit(FetchAvailableOffersErrorState());
      debugPrint("Error fetching products or offerings: ${e.toString()}");
    }
  }

  Future<void> purchasePackage(Package package) async {
    try {
      // Make a purchase
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);
      bool isProUser =
          customerInfo.entitlements.all["premium_access"]?.isActive ?? false;

      if (isProUser) {
        // User has successfully subscribed
        print("Subscription successful!");
      } else {
        // Handle subscription failure
        print("Subscription not active.");
      }
    } catch (e) {
      print("Error making purchase: $e");
    }
  }
}
