import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/enums.dart';
import 'package:v_commerce/presentation/UI/screens/splash/splash_screen3.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/splashController.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.find();
    return Scaffold(

      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset("assets/images/splash2.png",fit: BoxFit.fill,width: double.infinity,)
          ,
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 70),
           child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich( TextSpan(children:[TextSpan(text:'${AppLocalizations.of(context)!.continue_as} ',style: AppTextStyle.splashTextStyle),const WidgetSpan(child: Icon(Icons.arrow_forward,color: AppColors.white,),alignment: PlaceholderAlignment.middle,) ]),textAlign: TextAlign.center,),
                                    const SizedBox(height: 40,),
                  MyButton(text: AppLocalizations.of(context)!.professional, click: (){
                      splashController.role=UserRole.vendor;
                   
                          Navigator.push(
          context,
          CupertinoPageRoute(
              builder:(_)=>const SplashScreen3()));
                  },color: AppColors.primary,),
                  const SizedBox(height: 40,),
                                  MyButton(text: AppLocalizations.of(context)!.client, click: (){
                                     splashController.role=UserRole.user;
                          Navigator.push(
          context,
          CupertinoPageRoute(
              builder:(_)=>const SplashScreen3()));
                                  })
         
                ],
              ),
         ),
        ],
      ),
    );
  }
}