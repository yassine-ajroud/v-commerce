import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/Widgets/input.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';


class UpdatePasswordScreen extends StatefulWidget {
   const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
    final _formKey = GlobalKey<FormState>();
  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final SettingsController settingsController = Get.find();

@override
  void dispose() {
    currentPassword.dispose();
    password.dispose();
    cpassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          foregroundColor: AppColors.black,
          automaticallyImplyLeading: true,
              surfaceTintColor: AppColors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<AuthenticationController>(
            init: AuthenticationController(),
            builder: (controller) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                                alignment:Adaptivity.alignmentLeft(settingsController.currentlocale),
                                child: Text(
                                    style: AppTextStyle.titleTextStyle,
                                    AppLocalizations.of(context)!.change_password)),
                                        const SizedBox(
                        height: 20,
                      ),
                       InputText(
                        leading: APPSVG.lockIcon,
                        hint: AppLocalizations.of(context)!.current_password,
                        controler: currentPassword,
                        isPassword: true,
                              validator: (v){
                                 if(v!.length<8 || v.isEmpty){
                                return AppLocalizations.of(context)!.invalid_password;
                              }
                              return null;
                              },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                        leading: APPSVG.lockIcon,
                        hint: AppLocalizations.of(context)!.password,
                        controler: password,
                         isPassword: true,
                              validator: (v){
                                 if(v!.length<8 || v.isEmpty){
                                return AppLocalizations.of(context)!.invalid_password;
                              }
                              return null;
                              },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                          leading: APPSVG.lockIcon,
                          hint: AppLocalizations.of(context)!.confirm_password,
                          type: TextInputType.text,
                           isPassword: true,
                              validator: (v){
                                 if(v!.isEmpty || v!=password.text){
                                return AppLocalizations.of(context)!.password_does_not_match;
                              }
                              return null;
                            
                          }),
                
                          SizedBox(height: 30.h,),
                          MyButton(text: AppLocalizations.of(context)!.save, click: ()async{
                            if(_formKey.currentState!.validate()){
                                  await controller.updatePassword(currentPassword, password, cpassword, context);
                            }
                          })
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
