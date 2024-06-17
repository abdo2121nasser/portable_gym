import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';

import '../../generated/l10n.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
   getTopMenuImages({required int index})
   {
     List<String> images=[
       ImageManager.kWeightImage,
       ImageManager.kProgressTrackingImage,
       ImageManager.kNutraitionImage,
       ImageManager.kWeightImage,
     ];
     return images[index];
   }
  getTopMenuLables({required context,required int index}) {
    List<String> lables = [
      S.of(context).weight,
      S.of(context).progressTrack,
      S.of(context).nutraitions,
      S.of(context).weight,
    ];
    return lables[index];
  }


}
