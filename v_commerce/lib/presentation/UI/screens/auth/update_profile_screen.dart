import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/UI/Widgets/input.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.edit_user_infos,
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
                    controller.currentUser.oAuth!=null? Container():  InputText(
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
                     const CityInput(),
                           const SizedBox(
                        height: 10,
                      ),
                        const  DatePickerInput(),
                               const SizedBox(
                        height: 10,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
