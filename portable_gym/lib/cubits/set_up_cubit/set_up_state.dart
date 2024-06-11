part of 'set_up_cubit.dart';

@immutable
abstract class SetUpState {}

class SetUpInitial extends SetUpState {}
class IncrementPageBodyIndexState extends SetUpState {}
class DecrementPageBodyIndexState extends SetUpState {}
class GetAgeState extends SetUpState {}
class GetWeightState extends SetUpState {}
class GetHeightState extends SetUpState {}
class ChangeGenderState extends SetUpState {}
class PickImageLoadingState extends SetUpState {}
class PickImageSuccessState extends SetUpState {}
class PickImageErrorState extends SetUpState {}
