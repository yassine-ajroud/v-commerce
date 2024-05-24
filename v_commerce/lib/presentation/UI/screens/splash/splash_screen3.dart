import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/presentation/UI/screens/auth/login_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/signup_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset("assets/images/splash3.png",fit: BoxFit.fill,width: double.infinity,)
          ,
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 70),
           child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  MyButton(text: AppLocalizations.of(context)!.login, click: (){
                          Navigator.push(
          context,
          CupertinoPageRoute(
              builder:(_)=>const LoginScreen()));
                  },color: AppColors.primary,),
                  const SizedBox(height: 40,),
                                  MyButton(text: AppLocalizations.of(context)!.signUp, click: (){
                                                            Navigator.push(
          context,
          CupertinoPageRoute(
              builder:(_)=>const SignupScreen()));
                                  })
         
                ],
              ),
         ),
        ],
      ),
    );
  }
}