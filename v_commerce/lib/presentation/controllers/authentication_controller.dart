import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/domain/entities/user.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/create_account_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/facebook_login_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/get_user_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/google_login_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/login_usecase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/logout_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/reset_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/update_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/update_profil_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/update_user_image.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/verify_otp_usecase.dart';
import 'package:v_commerce/presentation/UI/screens/auth/login_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/otp_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/reset_password_screen.dart';
import 'package:v_commerce/presentation/UI/screens/main/main_screen.dart';
import 'package:v_commerce/presentation/controllers/category_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import '../../di.dart';
import '../../domain/entities/token.dart';
import '../../domain/usecases/authentication_usecases/clear_user_image.dart';
import '../../domain/usecases/authentication_usecases/forget_password_usecase.dart';
import '../UI/screens/auth/profile_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AuthenticationController extends GetxController{
  late Token token;
  late String myemail;
  bool termsAccepted=false;
  bool isLoading = false;
  late User currentUser;
  String userImage='';
    XFile? img;
  File? f;
  String? gender;
  String? birthDate;
  String?city;
  final ImagePicker _picker = ImagePicker();

  bool get missingData=>currentUser.phone=='' ||currentUser.address=='' || currentUser.birthDate==''||currentUser.gender=='' ;

  void setBirthDate(DateTime date){
    final year = date.year;
    final month = date.month;
    final day = date.day;
    birthDate = '$year-$month-$day';
    update();
  }

  void setGender(String value){
    gender=value;
    update();
  }
  void setCity(String value){
    city=value;
    update();
  }

  Future<void> pickImage()async{
    try {
        img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            f = File(img!.path);
                            setuserImage(basename(f!.path));
      }
    } catch (e) {
      print(e);
    }
    
  }

  void aceptTerms(bool v){
    termsAccepted=v;
    update(['terms']);
  }

   void setuserImage (String image) {
    userImage=image;
    update([ControllerID.UPDATE_USER_IMAGE]);
  }

  Future<void> updateImage(BuildContext context)async{
  if(userImage==''){
                  await ClearUserImageUsecase(sl())(currentUser.id!);
                }else{
                  await UpdateUserImageUsecase(sl()).call(userId:currentUser.id!,file:f!);
                }
                await getCurrentUser(currentUser.id!).then((value) => Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.profile_picture_updated,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0) );
                          
  }

  Future<void> login(TextEditingController email,TextEditingController password,BuildContext context)async{
    isLoading = true;
    update();
      final res = await LoginUsecase(sl())(email: email.text, password: password.text);
      res.fold((l) => Fluttertoast.showToast(
                          msg: l.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0), 
                          (r) async{
                            token = r;
                            email.clear();
                            password.clear();
                            await getCurrentUser(r.userId).then((value) {
                                                                                  Get.put(MyDrawerController()) ;
Get.put(CategoryController()) ;
    Get.put(ProductController()) ;
        Get.put(PromotionController());

                              return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const MainScreen()));
                            });
                          });
                                   isLoading = false;
    update();
  }

  Future<void> sendFrogetPasswordRequest(TextEditingController useremail,BuildContext context)async{
    String message='';
     final res = await ForgetPasswordUsecase(sl())(useremail.text);
        res.fold((l) =>message=l.message!
        , (r) {
          myemail = useremail.text;
          useremail.clear();
          message = AppLocalizations.of(context)!.email_sent;
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const OTPScreen()));
        } );

        Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
                          
  }

  Future<void> verifyOTP(TextEditingController otp,BuildContext context)async{
 final res = await OTPVerificationUsecase(sl())(email: myemail, otp: int.parse(otp.text));
      res.fold((l) =>   Fluttertoast.showToast(
                          msg: l.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0),
                          (r) {
                            otp.clear();
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ResetPasswordScreen()));
                          });
  }

  Future<void> resetPassword(TextEditingController password,TextEditingController cpassword,BuildContext context) async{
      String message='';
     final res = await ResetPasswordUsecase(sl())(password:password.text,email: myemail);
        res.fold((l) =>message=l.message!
        , (r) {
          password.clear();
          cpassword.clear();
          message = AppLocalizations.of(context)!.password_reset;
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const LoginScreen()));
        } );
        Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0); 

  }

  Future<void> createAccount({required String  address,required TextEditingController email,required TextEditingController firstName,required TextEditingController lastName,required TextEditingController password,required TextEditingController cpassword,required TextEditingController phone,String? image, required String birthDate,required String gender ,required BuildContext context})async{
          final res = await CreateAccountUsecase(sl()).call(email: email.text, password: password.text,address: address,phone: phone.text,firstName: firstName.text,lastName: lastName.text,image: image??'',oauth: null,birthdate: birthDate,gender: gender);
      String message='';
      res.fold((l) => 
                          message= l.message!,
                          (r) {
                            message=AppLocalizations.of(context)!.account_created;
                            email.clear();
                            password.clear();
                            phone.clear();
                            firstName.clear();
                            lastName.clear();
                            cpassword.clear();
                            this.gender=null;
                            this.birthDate=null;
                            city=null;
                            termsAccepted=false;
                            update();

                          });
                          Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
  }

  Future<void> getCurrentUser(String userId)async{
      final res = await GetUserUsecase(sl())(userId);
      res.fold((l) => Fluttertoast.showToast(
                          msg: l.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0), 
                          (r) {
                            currentUser = r;
                            city=currentUser.address;
                            gender=currentUser.gender;
                            birthDate=currentUser.birthDate;
                            update();
                          });
  }

   Future<User> getUserById(String userId)async{
    late final User user;
      final res = await GetUserUsecase(sl())(userId);
      res.fold((l){},
                          (r) {
                           user=r;
                          });
                          return user;
  }
  

  Future<void> updateProfile({required String address,required TextEditingController email,required TextEditingController firstName,required TextEditingController lastName,required TextEditingController phone,required id,required String birthDate,required String gender ,required BuildContext context})async{
    String message='';
    print(currentUser.id);
 final res = await UpdateProfilUsecase(sl())(email: email.text,firstName: firstName.text,lastName: lastName.text,address: address,phone:phone.text,id:id,gender: gender,birthDate: birthDate);
      res.fold((l) => message=l.message!,
                          (r) async{
                            message = AppLocalizations.of(context)!.profile_updated;
                            await getCurrentUser(currentUser.id!);
                          });
                           Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
  }

  Future<void> updatePassword(TextEditingController currentPassword, TextEditingController password,TextEditingController cPassword,BuildContext context)async{
String message='error';
 final res = await UpdatePasswordUsecase(sl())(userId:currentUser.id! ,newPassword: password.text,oldPassword: currentPassword.text);
      res.fold((l) => message=l.message!,
                          (r) async{
                            message = AppLocalizations.of(context)!.profile_updated;
                            password.clear();
                            cPassword.clear();
                            currentPassword.clear();
                          });
                           Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
  }

  Future<void> logout(BuildContext context)async{
                    isLoading = false;
    update();
    await LogoutUsecase(sl())();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginScreen()));
  }

  Future<void> facebookLogin(BuildContext context)async{
                   isLoading = true;
    
    final res =await FacebookLoginUsecase(sl())();
    res.fold((l) => null, (r)async {
          await CreateAccountUsecase(sl()).call(oauth:'F',email: r['id'].toString(), password: '0987654321',address: null,phone: '',firstName: r['name'].split(' ')[0].toString(),lastName: r['name'].split(' ')[1].toString(),image: r['picture']['data']['url'],birthdate: null,gender: null);

         final lg = await LoginUsecase(sl())(email: r['id'], password: '0987654321');
         lg.fold((l) => null, (r) async{
                                      token = r;
                                      await getCurrentUser(token.userId);
           return Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=> ProfileScreen()));
           
         });
    });
    isLoading = false;
    update();
  }

  Future<void> googleLogin(BuildContext context)async{
                   isLoading = true;
    
    final res =await GoogleLoginUsecase(sl())();
    res.fold((l) => null, (r)async {
          await CreateAccountUsecase(sl()).call(oauth:'G',email: r['email'], password: '0987654321',address: null,phone: '',firstName: r['firstName'],lastName: r['lastName'],image: r['image'],birthdate: null,gender: null);

         final lg = await LoginUsecase(sl())(email: r['email'], password: '0987654321');
         lg.fold((l) => null, (r) async{
                                      token = r;
                                      await getCurrentUser(token.userId);
           return Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=> ProfileScreen()));
           
         });
    });
    isLoading = false;
    update();
  }

}