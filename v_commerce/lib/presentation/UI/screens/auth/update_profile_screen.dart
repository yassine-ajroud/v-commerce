import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/Widgets/input.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../widgets/city_picker.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/gender_input.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
    final _formKey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final SettingsController settingsController = Get.find();

  @override
  void initState() {
    super.initState();
    AuthenticationController c = Get.find();
    firstname.text=c.currentUser.firstName;
                  lastname.text=c.currentUser.lastName;
                  email.text=c.currentUser.email;
                  phone.text=c.currentUser.phone;
                 c.birthDate=c.currentUser.birthDate;
                  c.gender=c.currentUser.gender;
                 c.city=c.currentUser.address;
  }

  @override
  void dispose() {
        AuthenticationController c = Get.find();

    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    address.dispose();
    email.dispose();
    super.dispose();
    c.birthDate=null;
    c.gender=null;
    c.city=null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
         // foregroundColor: AppColors.black,
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
        surfaceTintColor: Colors.transparent

        ),
        body: GetBuilder<AuthenticationController>(
          init: AuthenticationController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                          Align(
                                alignment:Adaptivity.alignmentLeft(settingsController.currentlocale),
                                child: Text(
                                    style: AppTextStyle.titleTextStyle,
                                    AppLocalizations.of(context)!.edit_user_infos)),
                                     const SizedBox(
                        height: 20,
                      ),
                       InputText(
                        leading: APPSVG.userIcon,
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
                        height: 20,
                      ),
                      InputText(
                        leading: APPSVG.userIcon,
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
                        height: 20,
                      ),
                    controller.currentUser.oAuth!=null? Container():  InputText(
                          leading: APPSVG.emailIcon,
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
                        height: 20,
                      ),
                      InputText(
                          leading: APPSVG.phoneIcon,
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
                        height: 20,
                      ),
                     const CityInput(),
                           const SizedBox(
                        height: 20,
                      ),
                        const  DatePickerInput(),
                               const SizedBox(
                        height: 20,
                      ),
                    const  GenderInput(),
                          SizedBox(height: 30.h,),
                          MyButton(text: AppLocalizations.of(context)!.save, click: ()async{
                            if(_formKey.currentState!.validate()){
                              
                                 if(controller.birthDate!=null&&controller.gender!=null && controller.city!=null){
                                   await controller.updateProfile(address: controller.city!, email: email, firstName: firstname, lastName: lastname, phone: phone, id:controller.currentUser.id,birthDate:controller.birthDate!,gender:controller.gender!,context: context);
                               
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
                              
                              
                              
                            }
                          })
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
