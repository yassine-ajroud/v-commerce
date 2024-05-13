import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/UI/screens/auth/login_screen.dart';
import 'package:v_commerce/presentation/UI/screens/main/home_screen.dart';
import 'package:v_commerce/presentation/UI/screens/main/main_screen.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/category_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/main_screen_controller.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import 'package:v_commerce/presentation/controllers/wishlist_controller.dart';

import '../../../../core/styles/colors.dart';
import '../../../../di.dart';
import '../../../../domain/usecases/authentication_usecases/auto_login_usecase.dart';
import '../../../../domain/usecases/authentication_usecases/get_user_usecase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Future<void> init(BuildContext context, int duration) async {
    Get.put(SettingsController()) ;
    Get.put(AuthenticationController()) ;
    
    Get.put(WishListController()) ;

    final  SettingsController settingsController = Get.find() ;
    final AuthenticationController authController = Get.find();
    final WishListController wishListController = Get.find();

    final lang = await settingsController.loadLocale();
    settingsController.setLocal(lang);
    bool res = true;
    final autologiVarReturn = await AutoLoginUsecase(sl()).call();
    autologiVarReturn.fold((l) {
       res = false;
    }, (r) async {
      authController.token = r;
      final user =
          await GetUserUsecase(sl()).call(r.userId);
      user.fold((l) {
         res = false;
      }, (r)async {
        authController.currentUser = r;
        final wishlist = await wishListController.getUserWishlist(authController.currentUser.id!);
                        Get.put(MyDrawerController()) ;
Get.put(CategoryController()) ;
    Get.put(ProductController()) ;
    Get.put(PromotionController());

      });
   
    });

    Future.delayed( Duration(seconds: duration), () {


      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => res ? const MainScreen():const LoginScreen()));
    });
  }
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SplashScreen.init(context, 2),
        builder:(_,snapshot)=> Container(
          width: 375.w,
          height: 812.h,
          color: AppColors.white,
          child: const Center(
            child: Text('Loading...'),
           // child: Container(
             // width: 198.w,
              //height: 198.h,
              //decoration: const BoxDecoration(
                //image: DecorationImage(
                  //  image: AssetImage(Assets.indar), fit: BoxFit.fitHeight),
              //),
            //),
          ),
        ),
      ),
    );
  }
}
