part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class InitRevenueCatWithApiLoadingState extends PaymentState {}
class InitRevenueCatWithApiSuccessState extends PaymentState {}
class InitRevenueCatWithApiErrorState extends PaymentState {}

class FetchOffersLoadingState extends PaymentState {}
class FetchOffersSuccessState extends PaymentState {}
class FetchOffersErrorState extends PaymentState {}

class PresentPayWallLoadingState extends PaymentState {}
class PresentPayWallSuccessState extends PaymentState {}
class PresentPayWallErrorState extends PaymentState {}
