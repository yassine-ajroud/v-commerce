import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';

class ProfessionalHomeScreen extends StatelessWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      drawer: Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.backgroundWhite,
      body: CustomScrollView(slivers: [
        SliverAppBar(
                   backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                       shadowColor: Colors.grey,
           automaticallyImplyLeading: false,
                            leading:GetBuilder(
                              init: MyDrawerController(),
                              builder: (drawerController) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: (){
                                      drawerController.toggleDrawer();
                                    },
                                    child: SvgPicture.string(APPSVG.menuIcon)),
                                );
                              }
                            ) ,
        )
      ]),
    ));
  }
}