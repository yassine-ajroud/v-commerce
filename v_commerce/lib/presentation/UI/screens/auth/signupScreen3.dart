
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/description_input.dart';
import 'package:v_commerce/presentation/UI/widgets/speciality_input.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';

class SignupScreen3 extends StatefulWidget {
    final TextEditingController firstname ;
  final TextEditingController lastname ;
   final TextEditingController email ;
  final TextEditingController password;
    final TextEditingController cpassword;
    final TextEditingController phone;

  const SignupScreen3({super.key,required this.firstname,required this.lastname,required this.email,required this.password,required this.cpassword,required this.phone});

  @override
  State<SignupScreen3> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen3> {
  final _formKey = GlobalKey<FormState>();
  final experience = TextEditingController();
  final description = TextEditingController();
  late final SettingsController settingsController;
  late final AuthenticationController authenticationController;

  @override
  void initState() {
    settingsController=Get.find();
    super.initState();
  }

    @override
  void dispose() {
    super.dispose();
    experience.dispose();
    description.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Align(
                  alignment: Adaptivity.alignmentLeft(settingsController.currentlocale),
                  child: GestureDetector(
                    onTap: (){
                        Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,size: 30,color: AppColors.black,),
                  )),
                         SizedBox(
                            height: 30.h,
                          ),
                    Align(
                        alignment:Adaptivity.alignmentLeft(settingsController.currentlocale),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width*0.9,
                          child: Text(
                              style: AppTextStyle.titleTextStyle,
                              AppLocalizations.of(context)!.create_your_account),
                        )),
                    SizedBox(
                            height: 30.h,
                          ),
                    DescriptionInput(
                      hint: AppLocalizations.of(context)!.description,
                      controler: description,
                      leading: APPSVG.userIcon,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .description_required;
                        }
                        return null;
                      },
                    ),
                     SizedBox(
                            height: 25.h,
                          ),
                  const  SpecialityInput(),
                    SizedBox(
                            height: 25.h,
                          ),
                    InputText(
                        hint: AppLocalizations.of(context)!.experience,
                        leading: APPSVG.experienceIcon,
                        type: TextInputType.number,
                        length: 2,
                        controler: experience,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .required_experience_years;
                          }
                          return null;
                        }),
                                                                      SizedBox(height: 20.h,),

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
                                  activeColor: AppColors.secondary,
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
                            Expanded(
                              child: Text.rich(
                                TextSpan(children:[ TextSpan(text:AppLocalizations.of(context)!.i_accept,style:AppTextStyle.smallblackTextStyle),
                              TextSpan(text: AppLocalizations.of(context)!.terms_and_conditions,style: AppTextStyle.smallblackTextButtonStyle )]),overflow: TextOverflow.visible,),
                            ),
                          ],
                        ),
                      ),
                    
                      SizedBox(
                            height: 35.h,
                          ),
                    GetBuilder<AuthenticationController>(
                      init: AuthenticationController(),
                      builder: (controller) {
                        return MyButton(
                          text: AppLocalizations.of(context)!.create_your_account,
                          click: () async {
                            if (_formKey.currentState!.validate()) {

                              if(controller.termsAccepted){
                                if(controller.birthDate!=null&&controller.gender!=null && controller.city!=null){
                                await controller.createAccount(
                                  cpassword: widget.cpassword,
                                  address: controller.city!,
                                  email: widget.email,
                                  phone: widget.phone,
                                  birthDate: controller.birthDate!,
                                  gender: controller.gender!,
                                  firstName: widget.firstname,
                                  lastName: widget.lastname,
                                  password: widget.password,
                                  description: description,
                                  experience: experience,
                                  isPro: true,
                                  context: context).then((value) => null);
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
                              else{

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
                      SizedBox(
                            height: 25.h,
                          ),
                    Row(
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
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
