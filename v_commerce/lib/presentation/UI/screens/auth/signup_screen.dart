
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/presentation/UI/widgets/date_picker.dart';
import 'package:v_commerce/presentation/UI/widgets/gender_input.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/button.dart';
import '../../widgets/city_picker.dart';
import '../../widgets/dialog.dart';
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
  final phone = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();

    @override
  void dispose() {
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    address.dispose();
    email.dispose();
    password.dispose();
    cpassword.dispose();
    final AuthenticationController c= Get.find();
    c.birthDate=null;
    c.gender=null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
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
                              AppLocalizations.of(context)!.signUp)),
                      const SizedBox(
                        height: 15,
                      ),
                      InputText(
                        hint: AppLocalizations.of(context)!.first_name,
                        controler: firstname,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .first_name_required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                        hint: AppLocalizations.of(context)!.last_name,
                        controler: lastname,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .last_name_required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                          hint: AppLocalizations.of(context)!.email,
                          type: TextInputType.emailAddress,
                          controler: email,
                          validator: (v) {
                            if (!v!.endsWith('@gmail.com') || v.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .invalid_email_address;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                          hint: AppLocalizations.of(context)!.password,
                          isPassword: true,
                          controler: password,
                          validator: (v) {
                            if (v!.length < 8) {
                              return AppLocalizations.of(context)!
                                  .invalid_password;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                          hint: AppLocalizations.of(context)!.confirm_password,
                          isPassword: true,
                          controler: cpassword,
                          validator: (v) {
                            if (v != password.text || v!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_does_not_match;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      InputText(
                          hint: AppLocalizations.of(context)!.phone_number,
                          type: TextInputType.phone,
                          controler: phone,
                          length: 8,
                          validator: (v) {
                            if (v!.length != 8) {
                              return AppLocalizations.of(context)!
                                  .phone_number_equired;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    const  CityInput(),
                           const SizedBox(
                        height: 10,
                      ),
                        const  DatePickerInput(),
                               const SizedBox(
                        height: 10,
                      ),
                      const GenderInput(),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GetBuilder<AuthenticationController>(
                              id: ControllerID.TERMS_AND_CONDITIONS,
                              init: AuthenticationController(),
                              builder: (controller) {
                                return Checkbox(
                                  activeColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  value: controller.termsAccepted,
                                  onChanged: (value) {
                                    controller.aceptTerms(value!);
                                  },
                                );
                              },
                            ),
                            Text(AppLocalizations.of(context)!.i_accept,
                                style: AppTextStyle.smallblackTextStyle),
                            TextButton(
                              clipBehavior: Clip.antiAlias,
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => const MyDialog());
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .terms_and_conditions,
                                style: AppTextStyle.smallblackTextButtonStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<AuthenticationController>(
                        init: AuthenticationController(),
                        builder: (controller) {
                          return MyButton(
                            text: AppLocalizations.of(context)!.signUp,
                            click: () async {
                              if (_formKey.currentState!.validate()) {
                                if(controller.termsAccepted){
                                  if(controller.birthDate!=null&&controller.gender!=null && controller.city!=null){
                                  await controller.createAccount(
                                    cpassword: cpassword,
                                    address: controller.city!,
                                    email: email,
                                    birthDate: controller.birthDate!,
                                    gender: controller.gender!,
                                    firstName: firstname,
                                    lastName: lastname,
                                    password: password,
                                    phone: phone,
                                    context: context);
                                  }else{
                                    Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.missing_data,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
                                  }
                                   
                                }else{

                                   Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.terms_and_conditions_required,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
  }
                                
                               
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 6,
                        ),
                        child: Row(
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
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
