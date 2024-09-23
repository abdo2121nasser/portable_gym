import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/screens/navigation_bar_screens/favourite_screen.dart';
import 'package:my_coach/screens/navigation_bar_screens/home_screen/home_screen.dart';
import 'package:my_coach/screens/navigation_bar_screens/resources_screen.dart';

part 'main_navigation_bar_state.dart';

class MainNavigationBarCubit extends Cubit<MainNavigationBarState> {
  MainNavigationBarCubit() : super(MainNavigationBarInitial());
  static MainNavigationBarCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> screens=[HomeScreen(),const ResourcesScreen(),const FavouriteScreen(),];
  List<BottomNavigationBarItem> items=[

    const BottomNavigationBarItem(icon: Icon(Icons.home,color:ColorManager.kWhiteColor,), label: '' ),
    const BottomNavigationBarItem(icon: Icon(Icons.description,color:ColorManager.kWhiteColor,), label: '' ),
    const BottomNavigationBarItem(icon: Icon(Icons.star,color:ColorManager.kWhiteColor,), label: '' ),

  ];
   changeCurrentScreen({required int index})
   {
     currentIndex=index;
     emit(ChangeScreenState());
   }
}
