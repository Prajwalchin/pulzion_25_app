import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarHome()); // Default to HomePage state

  int index = 2; // Default to home index (2)

  void changeIndex(int index) {
    this.index = index;
    switch (index) {
      case 0:
        emit(BottomBarAboutUs());
        break;
      case 1:
        emit(BottomBarRegisteredEvents());
        break;
      case 2:
        emit(BottomBarHome());
        break;
      case 3:
        emit(BottomBarCart());
        break;
      case 4:
        emit(BottomBarMore());
        break;
      default:
        emit(BottomBarHome());
    }
  }
}
