import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/favourite_screen_blocks/categories_body_blocks/recipe_category_body_block.dart';
import '../../resourses/blocks/favourite_screen_blocks/categories_body_blocks/training_category_body_block.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);

  int currentCategory=0;
 List<Widget> categories=[const TrainingCategoryBodyBlock(),const RecipeCategoryBodyBlock()];


  getFavouriteCategory(context){
    return [
      S.of(context).exercises,
      S.of(context).recipe,
    ];
  }
  changeCurrentCategory({required int index})
  {
    currentCategory=index;
    emit(ChangeCurrentCategory());
  }

}
