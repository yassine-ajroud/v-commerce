
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/enums.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/auth/login_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/signupScreen3.dart';
import 'package:v_commerce/presentation/UI/widgets/date_picker.dart';
import 'package:v_commerce/presentation/UI/widgets/gender_box.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import 'package:v_commerce/presentation/controllers/splashController.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/button.dart';
import '../../widgets/city_picker.dart';
import '../../widgets/input.dart';

class SignupScreen2 extends StatefulWidget {
  final TextEditingController firstname ;
  final TextEditingController lastname ;
   final TextEditingController email ;
  final TextEditingController password;
    final TextEditingController cpassword;

  const SignupScreen2({super.key, required this.firstname,required this.lastname,required this.email,required this.password,required this.cpassword});

  @override
  State<SignupScreen2> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final _formKey = GlobalKey<FormState>();
  
  final phone = TextEditingController();
  late final SettingsController settingsController;
  late final SplashController splashController;

  @override
  void initState() {
    settingsController=Get.find();
    splashController = Get.find();
    super.initState();
  }

    @override
  void dispose() {
    super.dispose();
    phone.dispose();
    final AuthenticationController c= Get.find();
    c.birthDate=null;
    c.gender=null;
    c.city=null;
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
                 
                  InputText(
                          hint: AppLocalizations.of(context)!.phone_number,
                          type: TextInputType.phone,
                                                  leading: APPSVG.phoneIcon,

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
                    const  CityInput(),
                           const SizedBox(
                        height: 30,
                      ),
                        const  DatePickerInput(),
                   
                    //  const GenderInput(),
                               const SizedBox(
                        height: 20,
                      ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Row(
                          children: [
                             SizedBox(
                              height: 40,
                             child: SvgPicture.string(APPSVG.genderIcon),
                            ),
                            Text('gender',style: AppTextStyle.blackTextStyle,)
                          ],
                                             ),
                       ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                        // ignore: prefer_const_constructors
                        GenderBox(icon: Icons.male,isMale: true,),
                        SizedBox(width: 20.w,),
                        // ignore: prefer_const_constructors
                        GenderBox(icon: Icons.female, isMale: false,)

                      ],),
                                              SizedBox(height: 20.h,),

                 splashController.role==UserRole.vendor?const SizedBox():  SizedBox(
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
                            height: 20.h,
                          ),
                    GetBuilder<AuthenticationController>(
                      init: AuthenticationController(),
                      builder: (controller) {
                        return MyButton(
                          text:splashController.role==UserRole.vendor?AppLocalizations.of(context)!.next : AppLocalizations.of(context)!.signUp,
                          click: () async {
                            if (_formKey.currentState!.validate()) {
                              if(splashController.role==UserRole.vendor&&controller.birthDate!=null&&controller.gender!=null && controller.city!=null){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SignupScreen3(
                                  firstname: widget.firstname,
                                  lastname: widget.lastname,
                                   cpassword: widget.cpassword,
                                  email: widget.email,
                                  phone: phone,
                                  password: widget.password,
                                )));
                              }else{
                              if(controller.termsAccepted){
                                if(controller.birthDate!=null&&controller.gender!=null && controller.city!=null){
                                await controller.createAccount(
                                  cpassword: widget.cpassword,
                                  address: controller.city!,
                                  email: widget.email,
                                  phone: phone,
                                  birthDate: controller.birthDate!,
                                  gender: controller.gender!,
                                  firstName: widget.firstname,
                                  lastName: widget.lastname,
                                  password: widget.password,
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
                            
                    }}},
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
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginScreen()));
                          },
                          child:  Text(
                            AppLocalizations.of(context)!.login,
                            style: AppTextStyle.blueTextButtonTextStyle,
                          ),
                        ),
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
