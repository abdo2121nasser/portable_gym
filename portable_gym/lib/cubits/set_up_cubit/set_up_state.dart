part of 'set_up_cubit.dart';

@immutable
abstract class SetUpState {}

class SetUpInitial extends SetUpState {}
class IncrementPageBodyIndexState extends SetUpState {}
class DecrementPageBodyIndexState extends SetUpState {}
