
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';

import 'button.dart';


class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find();
    return  AlertDialog(
  title: const Text("Êtes-vous sûr de vouloir vous déconnecter?"),
   titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20),
  backgroundColor: Colors.white,
  shape:const  RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  actionsPadding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
  actions: [
    TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Annuler')),
    MyButton(text: 'logout', click: ()async{
      await controller.logout(context);
    })
  ]
);
  }
}