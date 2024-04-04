
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/presentation/UI/screens/auth/signup_screen2.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  late final SettingsController settingsController;

  @override
  void initState() {
    settingsController=Get.find();
    super.initState();
  }

    @override
  void dispose() {
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    password.dispose();
    cpassword.dispose();
    final AuthenticationController c= Get.find();
    c.birthDate=null;
    c.gender=null;
    c.city=null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Align(
                  alignment: Adaptivity.alignmentLeft(settingsController.currentlocale),
                  child: GestureDetector(
                    onTap: (){
                        Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,size: 30,color: AppColors.black,),
                  )),
                         SizedBox(
                            height: 30.h,
                          ),
                    Align(
                        alignment:Adaptivity.alignmentLeft(settingsController.currentlocale),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width*0.9,
                          child: Text(
                              style: AppTextStyle.titleTextStyle,
                              AppLocalizations.of(context)!.create_your_account),
                        )),
                    SizedBox(
                            height: 30.h,
                          ),
                    InputText(
                      hint: AppLocalizations.of(context)!.first_name,
                      controler: firstname,
                      leading: Icons.person,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .first_name_required;
                        }
                        return null;
                      },
                    ),
                     SizedBox(
                            height: 25.h,
                          ),
                    InputText(
                      hint: AppLocalizations.of(context)!.last_name,
                      controler: lastname,
                      leading: Icons.person,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .last_name_required;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                            height: 25.h,
                          ),
                    InputText(
                        hint: AppLocalizations.of(context)!.email,
                        type: TextInputType.emailAddress,
                        leading: Icons.mail,
                        controler: email,
                        validator: (v) {
                          if (!v!.endsWith('@gmail.com') || v.isEmpty) {
                            return AppLocalizations.of(context)!
                                .invalid_email_address;
                          }
                          return null;
                        }),
                     SizedBox(
                            height: 25.h,
                          ),
                    InputText(
                        hint: AppLocalizations.of(context)!.password,
                        isPassword: true,
                        controler: password,
                        leading: Icons.lock,
                        validator: (v) {
                          if (v!.length < 8) {
                            return AppLocalizations.of(context)!
                                .invalid_password;
                          }
                          return null;
                        }),
                     SizedBox(
                            height: 25.h,
                          ),
                    InputText(
                        hint: AppLocalizations.of(context)!.confirm_password,
                        isPassword: true,
                        leading: Icons.lock,
                        controler: cpassword,
                        validator: (v) {
                          if (v != password.text || v!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .password_does_not_match;
                          }
                          return null;
                        }),
                      SizedBox(
                            height: 35.h,
                          ),
                    GetBuilder<AuthenticationController>(
                      init: AuthenticationController(),
                      builder: (controller) {
                        return MyButton(
                          text: AppLocalizations.of(context)!.next,
                          click: () async {
                            if (_formKey.currentState!.validate()) {

                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignupScreen2(
                                firstname: firstname,
                                lastname: lastname,
                                email: email,
                                password: password,
                                cpassword: cpassword,
                              )));             
                            }
                          },
                        );
                      },
                    ),
                      SizedBox(
                            height: 25.h,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(AppLocalizations.of(context)!.connect_to_your_account,
                            textAlign: TextAlign.center,style: AppTextStyle.smallblackTextStyle,),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:  Text(
                            AppLocalizations.of(context)!.login,
                            style: AppTextStyle.blueTextButtonTextStyle,
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
