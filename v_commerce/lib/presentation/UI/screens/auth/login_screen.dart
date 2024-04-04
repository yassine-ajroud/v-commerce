import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/presentation/UI/screens/auth/forget_password_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import '../../../../core/styles/text_styles.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';
import '../../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
 late final SettingsController settingsController; 

  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
  }

  @override
  void initState() {
    settingsController = Get.find();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
                  backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back,size: 30,)),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: GetBuilder<AuthenticationController>(
              init: AuthenticationController(),
              builder:(controller)=> controller.isLoading?const Center(child: CircularProgressIndicator(),) :Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            Align(
                                alignment:Adaptivity.alignmentLeft(settingsController.currentlocale),
                                child: Text(
                                    style: AppTextStyle.titleTextStyle,
                                    AppLocalizations.of(context)!.welcome_back)),
                             SizedBox(
                              height: 35.h,
                            ),
                            InputText(
                              hint: AppLocalizations.of(context)!.email,
                              leading: Icons.mail,
                              type: TextInputType.emailAddress,
                              controler: myController1,
                              validator: (v){
                                if(!v!.endsWith("@gmail.com")|| v.isEmpty){
                                  return AppLocalizations.of(context)!.invalid_email_address;
                                }
                                return null;
                              },
                            ),
                             SizedBox(
                              height: 25.h,
                            ),
                            InputText(
                                hint: AppLocalizations.of(context)!.password,
                                leading: Icons.lock,
                                isPassword: true,
                                controler: myController2,
                                validator: (v){
                                   if(v!.length<8 || v.isEmpty){
                                  return AppLocalizations.of(context)!.invalid_password;
                                }
                                return null;
                                },
                                ),
                            Align(
                              alignment: Adaptivity.alignmentRight(settingsController.currentlocale),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const ForgetPasswordScreen()));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.forgot_password,
                                   style: AppTextStyle.smallblackTextStyle,
                                  )),
                            ),
                             SizedBox(
                              height: 25.h,
                            ),
                           MyButton(
                                text: AppLocalizations.of(context)!.login,
                                click: () async{
                                 if( _formKey.currentState!.validate()){
                                    await controller.login(myController1, myController2,context);
                                 }
                                  
                                },
                              ),
                             SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                             const Expanded(child: Divider(color: AppColors.black,thickness: 1,endIndent: 20,indent: 0,)),
                              Text(AppLocalizations.of(context)!.or_continue_with),
                                const Expanded(child: Divider(color: AppColors.black,thickness: 1,endIndent: 0,indent: 20,)),

                            ],),
                             SizedBox(
                              height: 25.h,
                            ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal:40.0),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                       SocialSecondaryButton(text: AppLocalizations.of(context)!.continue_with_facebook, onClick: () async{
                                      await controller.facebookLogin(context);
                                    }, asset: 'assets/images/facebook.png'),
                                   SocialSecondaryButton(text: AppLocalizations.of(context)!.continue_with_google, onClick: ()async {
                                        await controller.googleLogin(context);
                             
                                   }, asset: 'assets/images/google.png'),
                                   
                                 ],
                                 
                               ),
                             ),
                               SizedBox(height: 25.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(AppLocalizations.of(context)!.dont_have_account,
                                    textAlign: TextAlign.center,style: AppTextStyle.smallblackTextStyle,),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>const SignupScreen()));
                                  },
                                  child:  Text(
                                    AppLocalizations.of(context)!.signUp,
                                    style:AppTextStyle.blueTextButtonTextStyle,
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
