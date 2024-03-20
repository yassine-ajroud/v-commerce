import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/text_styles.dart';
import '../../Widgets/input.dart';
import '../../widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreen();
}

class _OTPScreen extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final otp = TextEditingController();

  @override
  void dispose() {
    otp.clear();
    super.dispose();
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      style: AppTextStyle.titleTextStyle,
                      AppLocalizations.of(context)!.verification),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      style: AppTextStyle.greyTitleTextStyle,
                      AppLocalizations.of(context)!.otp_sent_to_your_email),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: InputText(
                      hint: AppLocalizations.of(context)!.code,
                      type: TextInputType.number,
                      length: 4,
                      controler: otp,
                      validator: (v) {
                        if (v!.length != 4) {
                          return AppLocalizations.of(context)!.code_invalid;
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
                          click: () async {
                            if (_formKey.currentState!.validate()) {
                             await controller.verifyOTP(otp, context);
                            }
                          },
                        );
                      },
                
                )
              ]),
        ),
      ),
    );
  }
}
