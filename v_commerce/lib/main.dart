import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/presentation/UI/screens/splash/splash_screen1.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/category_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';
import 'package:v_commerce/presentation/controllers/splashController.dart';
import 'core/l10n/l10n.dart';
import 'di.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    Get.put(AuthenticationController());
      Get.put(SplashController());
      Get.put(MyDrawerController());
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          controller.loadLocale();
          return FutureBuilder(
            future: controller.loadLocale(),
            builder: (_,snapshot) {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (_, child) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                          title: 'Flutter Demo',
                          theme: ThemeData(
                            colorScheme: ColorScheme.fromSeed(
                                seedColor: Colors.deepPurple),
                            useMaterial3: true,
                          ),
                          home: const SplashScreen(),
                          supportedLocales: L10n.all,
                          locale: Locale(controller.currentlocale),
                          localizationsDelegates: const [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate
                          ]));
            },
          );
        });
  }
}
