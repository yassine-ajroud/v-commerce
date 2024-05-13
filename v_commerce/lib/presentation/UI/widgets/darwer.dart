import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/settings/language_settings.dart';
import 'package:v_commerce/presentation/UI/widgets/drawer_item.dart';
import 'package:v_commerce/presentation/UI/widgets/log_out_dialog.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController=Get.find();
    return GetBuilder<MyDrawerController>(
      init: MyDrawerController(),
      builder: (controller) {
        return Drawer(
          backgroundColor: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              ListTile(
                leading:authenticationController.currentUser.image==""?const CircleAvatar(backgroundColor: AppColors.grey,radius: 30,): CircleAvatar(backgroundImage: NetworkImage(authenticationController.currentUser.image!),radius: 30,),
                title: Text('${authenticationController.currentUser.firstName} ${authenticationController.currentUser.lastName}',style: AppTextStyle.smallBlackTitleTextStyle,),
                subtitle:Text(authenticationController.currentUser.oAuth==null?authenticationController.currentUser.email:'' ) ,),
                const SizedBox(height: 20,),
                DrawerItem(label: 'Profile', icon: APPSVG.profileIcon, index: 0, onTap: (){controller.selectDrawerItem(0);}, groupeIndex: controller.groupeValue),
                DrawerItem(label: 'Messagerie', icon: APPSVG.messageIcon, index: 1, onTap: (){controller.selectDrawerItem(1);}, groupeIndex: controller.groupeValue),
                DrawerItem(label: 'Notifications', icon: APPSVG.notificationIcon, index: 2, onTap: (){controller.selectDrawerItem(2);}, groupeIndex: controller.groupeValue),
                DrawerItem(label: 'Mes Commandes', icon: APPSVG.commandIcon, index: 3, onTap: (){controller.selectDrawerItem(3);}, groupeIndex: controller.groupeValue),
                DrawerItem(label: 'Paramètres ', icon: APPSVG.settingsIcon, index: 4, onTap: (){controller.selectDrawerItem(4);
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SelectLanguageScreen()));
                }, groupeIndex: controller.groupeValue),
                DrawerItem(label: 'Se déconnecté', icon: APPSVG.logoutIcon, index: 5, onTap: ()async{controller.selectDrawerItem(0);  showDialog(context: context, builder: ((ctx) =>const LogoutDialog() ));}, groupeIndex: controller.groupeValue),

            ]),
          ),
        );
      }
    );
  }
}