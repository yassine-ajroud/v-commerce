import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/presentation/UI/screens/main/main_screen.dart';
import 'package:v_commerce/presentation/UI/screens/services/professional_home_screen.dart';
import 'package:v_commerce/presentation/UI/screens/splash/splash_screen2.dart';

import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/cart_controller.dart';
import 'package:v_commerce/presentation/controllers/category_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import 'package:v_commerce/presentation/controllers/service_category_controller.dart';
import 'package:v_commerce/presentation/controllers/service_controller.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import 'package:v_commerce/presentation/controllers/wishlist_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../di.dart';
import '../../../../domain/usecases/authentication_usecases/auto_login_usecase.dart';
import '../../../../domain/usecases/authentication_usecases/get_user_usecase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Future<void> init(BuildContext context, int duration) async {
            bool isPro=false;

    Get.put(SettingsController()) ;
    Get.put(AuthenticationController()) ;
    Get.put(CartController());
    Get.put(WishListController()) ;

    final  SettingsController settingsController = Get.find() ;
    final AuthenticationController authController = Get.find();
    final WishListController wishListController = Get.find();
    final CartController cartController = Get.find();

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
        if(r.role=="user"){
        await wishListController.getUserWishlist(authController.currentUser.id!);
        await cartController.getUserCart(authController.currentUser.id!);
        
Get.put(CategoryController()) ;
    Get.put(ProductController()) ;
    Get.put(PromotionController());
        }else{
          isPro=true;
        }
                        Get.put(MyDrawerController()) ;
                        Get.put(ServiceCategoryController()) ;
                        Get.put(ServiceController());


      });
   
    });

    Future.delayed( Duration(seconds: duration), () {


      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder:(_)=>res ? isPro?const ProfessionalHomeScreen() : const MainScreen():const SplashScreen2()));
    });
  }
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image.asset("assets/images/splash 1.png",fit: BoxFit.cover,width: double.infinity,height: MediaQuery.sizeOf(context).height,)
            ,
            FutureBuilder(
              future: SplashScreen.init(context, 2),
              builder:(_,snapshot)=> Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 10,),
                  Center(
                    child:Image.asset('assets/images/logoWhite.png',width: 150.w,)
                   // child: Container(
                     // width: 198.w,
                      //height: 198.h,
                      //decoration: const BoxDecoration(
                        //image: DecorationImage(
                          //  image: AssetImage(Assets.indar), fit: BoxFit.fitHeight),
                      //),
                    //),
                  ),
                  const SizedBox(height: 180,),
    
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SizedBox(
                      width: 300.w,
                      child: Text(AppLocalizations.of(context)!.splash_text,style: AppTextStyle.splashTextStyle,)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
