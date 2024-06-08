import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../resourses/blocks/set_up_bodies_blocks/age_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/gender_set_up_block.dart';
import '../../resourses/blocks/set_up_bodies_blocks/weight_set_up_block.dart';

part 'set_up_state.dart';

class SetUpCubit extends Cubit<SetUpState> {
  SetUpCubit() : super(SetUpInitial());
  static SetUpCubit get(context)=>BlocProvider.of(context);

  List<Widget> pageBody=[GenderSetUpBlock(),AgeSetUpBlock(),WeightSetUpBlock()];



}
