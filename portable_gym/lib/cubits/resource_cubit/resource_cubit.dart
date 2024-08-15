import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/resources_blocks/bodies_blocks/nutrition_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/resources_blocks/bodies_blocks/work_out_body_block.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  ResourceCubit() : super(ResourceInitial());
  static ResourceCubit get(context) => BlocProvider.of(context);


  int currentResource=0;
  List<Widget> resourcesBodies=[const WorkOutBodyBlock(),const NutritionBodyBlock()];

  changeCurrentResource({required int index}){
    currentResource=index;
    emit(ChangeCurrentResourceState());
  }

  getResourceLables({required context}) {
    return [
      S.of(context).workOut,
      S.of(context).nutrition,
    ];
  }

}
