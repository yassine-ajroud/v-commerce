import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/presentation/UI/Widgets/input.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        appBar: AppBar(
          foregroundColor: AppColors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.change_password,
            maxLines: 2,
            softWrap: true,
            style: AppTextStyle.secondaryBlackTitleTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<AuthenticationController>(
            init: AuthenticationController(),
            builder: (controller) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                       InputText(
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
