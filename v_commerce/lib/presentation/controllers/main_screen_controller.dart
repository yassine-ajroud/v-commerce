import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:v_commerce/presentation/UI/screens/main/category_screen.dart';
import 'package:v_commerce/presentation/UI/screens/main/home_screen.dart';
import 'package:v_commerce/presentation/UI/screens/main/service_screen.dart';
import 'package:v_commerce/presentation/UI/screens/main/wishlist_screen.dart';

class MainScreenController extends GetxController{
  int selectedScreen=0;
  List<Widget> screens=[HomeScreen(),CategoryScreen(),ServiceScreen(),WishListScreen()];

  void selectScreen(int index){
    selectedScreen=index;
    update();
  }
}