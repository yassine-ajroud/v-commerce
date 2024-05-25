import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/adaptive.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/contact_button.dart';
import 'package:v_commerce/presentation/UI/widgets/pro_rating_section.dart';
import 'package:v_commerce/presentation/UI/widgets/professional_description_card.dart';
import 'package:v_commerce/presentation/UI/widgets/professional_infos_card.dart';
import 'package:v_commerce/presentation/controllers/service_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController=Get.find();
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: ServiceController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getCurrentService(),
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
                                    leading:IconButton(
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    padding: EdgeInsets.zero,
                    icon:const Icon(Icons.arrow_back,size: 30,))  
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
                      ProfessionalInfoCard(serviceId: controller.selectedService.service,user: controller.selectedUser,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                                              ContactButon(color: AppColors.secondary,text: 'Appelez-moi',onClick: ()async{
                                                 Uri url=Uri(scheme: 'tel',path:controller.selectedUser.phone ) ;
                                                 if (!await launchUrl(url)) {
                                                  print("error");
                                                throw Exception('Could not launch $url');

                                                
                                                }
                                              },icon: APPSVG.phoneIcon,),
                      ContactButon(color: AppColors.primary,text: 'Contactez-moi',onClick: (){},icon: APPSVG.messageIcon,),
                    ],),
                                        const SizedBox(height: 20,),
                    ProfessionalDescriptionCard(description: controller.selectedService.description, experience: controller.selectedService.experience),
                     const SizedBox(height: 20,),
Text('Photos',style: AppTextStyle.blackTitleTextStyle,),
                     
                                               const SizedBox(height: 10,),

                   controller.selectedService.images.isEmpty?   Container(
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
          itemCount:   controller.selectedService.images.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
         return ClipRRect(
          borderRadius: BorderRadius.circular(25),
           child: Image.network(controller.selectedService.images[itemIndex],
           fit: BoxFit.cover,
           width: double.infinity,
                 height: 200.h, 
           ),
         );
          }
        ),
                          
        const SizedBox(height: 10,),
             Center(
              child: AnimatedSmoothIndicator( 
                 activeIndex: controller.serviceImagesindex,
               //controller: controller.serviceImagesController,  // PageController  
               count:  controller.selectedService.images.length,  
               effect: const WormEffect(dotWidth: 10,dotHeight: 10,activeDotColor: AppColors.secondary),  // your preferred effect  
            ),
            )
          
        ,
                const SizedBox(height: 20,),

        Text('Avis clients',style: AppTextStyle.blackTitleTextStyle,),
        ProfessionalRatingSection(cout: controller.selectedService.cost??0.0, politesse: controller.selectedService.courtesy??0.0, ponctualite: controller.selectedService.ponctuality??0.0, qualite: controller.selectedService.quality??0.0)
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