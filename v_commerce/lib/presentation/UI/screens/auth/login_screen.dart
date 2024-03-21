import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/google_login_usecase.dart';
import 'package:v_commerce/presentation/UI/screens/auth/forget_password_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
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

  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: GetBuilder<AuthenticationController>(
              init: AuthenticationController(),
              builder:(controller)=> controller.isLoading?Center(child: CircularProgressIndicator(),) :Column(
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
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    style: AppTextStyle.titleTextStyle,
                                    AppLocalizations.of(context)!.login)),
                            const SizedBox(
                              height: 15,
                            ),
                            InputText(
                              hint: AppLocalizations.of(context)!.email,
                              type: TextInputType.emailAddress,
                              controler: myController1,
                              validator: (v){
                                if(!v!.endsWith("@gmail.com")|| v.isEmpty){
                                  return AppLocalizations.of(context)!.invalid_email_address;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputText(
                                hint: AppLocalizations.of(context)!.password,
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
                              alignment: Alignment.topRight,
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
                            const SizedBox(
                              height: 20,
                            ),
                           MyButton(
                                text: AppLocalizations.of(context)!.login,
                                click: () async{
                                 if( _formKey.currentState!.validate()){
                                    await controller.login(myController1, myController2,context);
                                 }
                                  
                                },
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                             SocialSecondaryButton(text: AppLocalizations.of(context)!.continue_with_google, onClick: ()async {
                                  await GoogleLoginUsecase(sl())();

                             }, asset: 'assets/images/google.png'),
                                  const SizedBox(height: 10,),
                                  SocialSecondaryButton(text: AppLocalizations.of(context)!.continue_with_facebook, onClick: () async{
                                    await controller.facebookLogin(context);
                                  }, asset: 'assets/images/facebook.png'),
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
                                    AppLocalizations.of(context)!.register,
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
