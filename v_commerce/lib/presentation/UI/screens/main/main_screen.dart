import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/UI/screens/main/home_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/bottom_nav_bar.dart';
import 'package:v_commerce/presentation/UI/widgets/darwer.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyDrawerController controller=Get.find();
    return  SafeArea(
      child: Scaffold(
        key:controller.scaffoldKey ,
        drawer:const MyDrawer(),
    
      
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
           const HomeScreen(),
              
          const BottomNavBar(),
          ],
        ),
       
      ),
    );
  }
}