import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/UI/widgets/bottom_nav_bar.dart';
import 'package:v_commerce/presentation/UI/widgets/darwer.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //MyDrawerController controller=Get.find();
    return  SafeArea(
      child: GetBuilder(
        init: MainScreenController(),
        builder: (mainScreenController) {
          return GetBuilder(
            init : MyDrawerController(),
            builder: (controller) {
              return Scaffold(
                key:controller.scaffoldKey ,
                drawer:const MyDrawer(),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton:BottomNavBar() ,
                body:
                   mainScreenController.screens[mainScreenController.selectedScreen],
    
              );
            }
          );
        }
      ),
    );
  }
}