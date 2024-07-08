import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());
  static NutritionCubit get(context) => BlocProvider.of(context);
 int currentPlane=0;
  getMealPlaneLabel({context})
  {
    List<String> lables=[
       S.of(context).mealPlan,
       S.of(context).mealIdea,
    ];
    return lables;
  }
  changeCurrentPlane({required int index})
  {
    currentPlane=index;
    emit(ChangeCurrentPlaneState());
  }

}
