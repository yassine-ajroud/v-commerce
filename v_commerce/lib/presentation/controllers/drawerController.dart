import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawerController extends GetxController{
  int groupeValue=0;
             GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  selectDrawerItem(int index){
    groupeValue = index;
    update();
  }

  toggleDrawer(){
    scaffoldKey.currentState!.openDrawer();
  }



}