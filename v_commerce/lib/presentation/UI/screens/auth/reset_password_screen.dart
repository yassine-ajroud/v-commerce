import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/text_styles.dart';
import '../../Widgets/input.dart';
import '../../widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final newPassword = TextEditingController();
  final newPasswordconfirm = TextEditingController();

  @override
  void dispose() {
    newPassword.clear();
    newPasswordconfirm.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
                  surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: AppTextStyle.titleTextStyle,
                        AppLocalizations.of(context)!.reset_password),
                  ),
          
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputText(
                                    hint: AppLocalizations.of(context)!.password,
                                    isPassword: true,
                                    //icon: const Icon(Icons.visibility),
                                    controler: newPassword,
                                    validator: (v){
                                       if(v!.length<8){
                                      return AppLocalizations.of(context)!.invalid_password;
                                    }
                                    return null;
                                    },
                                    
                          ),
            const SizedBox(
                    height: 20,
                  ),
                          InputText(
                                hint: AppLocalizations.of(context)!.confirm_password,
                                isPassword: true,
                                controler: newPasswordconfirm,
                                validator: (v){
                                   if(v!.length<8 || v!=newPassword.text){
                                  return AppLocalizations.of(context)!.invalid_password;
                                }
                                return null;
                                },
                                ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                 GetBuilder<AuthenticationController>(
                   init: AuthenticationController(),
                   builder: (controller) {
                     return MyButton(
                                         text: AppLocalizations.of(context)!.reset,
                                         click: () async{
                                           if (_formKey.currentState!.validate()) {
                                           await  controller.resetPassword(newPassword, newPasswordconfirm, context);
                                           }
                                         },
                                       ); 
                   },
                 )
                ]),
          ),
        ),
      ),
    );
  }
}
