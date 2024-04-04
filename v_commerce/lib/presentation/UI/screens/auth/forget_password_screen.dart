import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/presentation/UI/widgets/input.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/text_styles.dart';
import '../../widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();

@override
  void dispose() {
    super.dispose();
    email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
             icon:const Icon(Icons.arrow_back,size: 30,)),
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
                        style: AppTextStyle.titleTextStyle, AppLocalizations.of(context)!.get_verification_code),
                  ),
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: AppTextStyle.descriptionTextStyle, AppLocalizations.of(context)!.verification_code_details),
                  ),
                   SizedBox(
                    height: 30.h,
                  ),
                  Form(
                      key: _formKey,
                      child: InputText(
                        hint: AppLocalizations.of(context)!.email,
                        type: TextInputType.emailAddress,
                        leading: Icons.email,
                        controler: email,
                        validator: (v) {
                          if (!v!.endsWith("@gmail.com") || v.isEmpty) {
                            return AppLocalizations.of(context)!
                                .invalid_email_address;
                          }
                          return null;
                        },
                      )),
                   SizedBox(
                    height: 30.h,
                  ),
                  GetBuilder<AuthenticationController>(
                    init: AuthenticationController(),
                    builder: (controller) {
                      return MyButton(
                        text: AppLocalizations.of(context)!.send,
                        click: () async{
                          if (_formKey.currentState!.validate()) {
                          await  controller.sendFrogetPasswordRequest(email, context);
                          }
                        },
                      );
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
