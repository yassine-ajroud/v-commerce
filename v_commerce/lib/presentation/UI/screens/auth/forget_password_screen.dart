import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/text_styles.dart';
import '../../Widgets/input.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.white10,
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
                        style: AppTextStyle.titleTextStyle, AppLocalizations.of(context)!.get_verification_code),
                  ),
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: AppTextStyle.descriptionTextStyle, AppLocalizations.of(context)!.verification_code_details),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: _formKey,
                      child: InputText(
                        hint: AppLocalizations.of(context)!.email,
                        type: TextInputType.emailAddress,
                        controler: email,
                        validator: (v) {
                          if (!v!.endsWith("@gmail.com") || v.isEmpty) {
                            return AppLocalizations.of(context)!
                                .invalid_email_address;
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20,
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
