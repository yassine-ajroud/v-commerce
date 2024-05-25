import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/pro_drawer.dart';
import 'package:v_commerce/presentation/UI/widgets/pro_rating_section.dart';
import 'package:v_commerce/presentation/UI/widgets/professional_description_card.dart';
import 'package:v_commerce/presentation/UI/widgets/professional_infos_card.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/service_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

class ProfessionalHomeScreen extends StatelessWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController=Get.find();
    MyDrawerController drawerController = Get.find();
    drawerController.scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(child: Scaffold(
                      key:drawerController.scaffoldKey ,
      drawer:const ProfessionalDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: ServiceController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getCurrentUserService(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                 return CustomScrollView(slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                           backgroundColor: Colors.white,
                                    surfaceTintColor: Colors.white,
                               shadowColor: Colors.grey,
                   automaticallyImplyLeading: false,
                                    leading:GetBuilder(
                                      init: MyDrawerController(),
                                      builder: (drawerController) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: InkWell(
                                            onTap: (){
                                              drawerController.toggleDrawer();
                                            },
                                            child: SvgPicture.string(APPSVG.menuIcon)),
                                        );
                                      }
                                    ) ,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Align(
                                alignment:Adaptivity.alignmentLeft(settingsController.currentlocale),
                                child: Text(
                                    style: AppTextStyle.blackTitleTextStyle,
                                    AppLocalizations.of(context)!.pro_profile)),
                                                        const SizedBox(height: 20,),
                      ProfessionalInfoCard(serviceId: controller.currentUserService.service,),
                    const SizedBox(height: 20,),
                    ProfessionalDescriptionCard(description: controller.currentUserService.description, experience: controller.currentUserService.experience),
                     const SizedBox(height: 20,),

                     Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Photos',style: AppTextStyle.blackTitleTextStyle,),
                          IconButton(onPressed: ()async{
                            await controller.pickImage(context);

                          }, icon: const Icon(Icons.add))]),
                                               const SizedBox(height: 10,),

                   controller.currentUserService.images.isEmpty?   Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 4,color: AppColors.extraLightBlueColor)
                        ),
                        width: double.infinity,
                        height: 200.h,
                        child: SvgPicture.string(APPSVG.imagePlaceHolderIcon,fit: BoxFit.scaleDown,)):
                        
                        
                             CarouselSlider.builder(
                                
                                    options: CarouselOptions(height: 200.h,
                       viewportFraction: 1,
            onPageChanged: (index, reason) => controller.setImageIndex(index),
                                    enableInfiniteScroll :false,
                                    autoPlay :false,
                                    enlargeCenterPage: true,
                                    autoPlayInterval :const Duration(seconds: 5)
                                    ),
          itemCount:   controller.currentUserService.images.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
         return PopupMenuButton(
             onSelected: (value) async {
                                switch (value) {
                                  case "/update":
                                 await  controller.updateImage(context,controller.currentUserService.images[itemIndex]);
                                    break;
                                  case "/delete":
                                    await controller.removeImage(controller.currentUserService.images[itemIndex]);
                                    break;
                                }
                              },
                              enableFeedback: true,
                              enabled:true,
                              itemBuilder: ((context) =>  [
                                    PopupMenuItem(
                                      value: "/update",
                                      child: Text(AppLocalizations.of(context)!.edit),
                                    ),
                                    PopupMenuItem(
                                        value: "/delete", child: Text(AppLocalizations.of(context)!.delete))]),
           child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
             child: Image.network(controller.currentUserService.images[itemIndex],
             fit: BoxFit.cover,
             width: double.infinity,
                   height: 200.h, 
             ),
           ),
         );
          }
        ),
                          
        const SizedBox(height: 10,),
             Center(
              child: AnimatedSmoothIndicator( 
                 activeIndex: controller.serviceImagesindex,
               //controller: controller.serviceImagesController,  // PageController  
               count:  controller.currentUserService.images.length,  
               effect: const WormEffect(dotWidth: 10,dotHeight: 10,activeDotColor: AppColors.secondary),  // your preferred effect  
            ),
            )
          
        ,
                const SizedBox(height: 20,),

        Text('Avis clients',style: AppTextStyle.blackTitleTextStyle,),
        ProfessionalRatingSection(cout: controller.currentUserService.cost??0.0, politesse: controller.currentUserService.courtesy??0.0, ponctualite: controller.currentUserService.ponctuality??0.0, qualite: controller.currentUserService.quality??0.0)
                    ],),
                  ),
                )
              ]);
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
             
            }
          );
        }
      ),
    ));
  }
}