part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class InitRevenueCatWithApiState extends PaymentState {}

class FetchAvailableOffersLoadingState extends PaymentState {}
class FetchAvailableOffersSuccessState extends PaymentState {}
class FetchAvailableOffersErrorState extends PaymentState {}
