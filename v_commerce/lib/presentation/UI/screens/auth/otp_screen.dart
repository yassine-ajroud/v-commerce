import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/text_styles.dart';
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
  final OtpFieldControllerV2 controllerV2 = OtpFieldControllerV2();

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
          automaticallyImplyLeading: true,
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
                 const SizedBox(
                  height: 10,
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
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: OTPTextFieldV2(
                                controller: controllerV2,
                                length: 4,
                                width: 250.w,
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldWidth: 45,
                                fieldStyle: FieldStyle.box,
                                outlineBorderRadius: 15,
                                style: AppTextStyle.blackTextStyle,
                                onChanged: (pin) {
                                  otp.text=pin;
                                },
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                },
                    ),
                    ),),
                const SizedBox(
                  height: 40,
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
