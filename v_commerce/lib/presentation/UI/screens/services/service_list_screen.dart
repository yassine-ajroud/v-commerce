import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/cart/cart_screen.dart';
import 'package:v_commerce/presentation/UI/screens/services/professional_proflie_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/search_input.dart';
import 'package:v_commerce/presentation/UI/widgets/service_item.dart';
import 'package:v_commerce/presentation/controllers/service_controller.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceController categoryController=Get.find();

    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: FutureBuilder(
        future: categoryController.getAllServices(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
 return CustomScrollView(
            slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                             leading:IconButton(
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    padding: EdgeInsets.zero,
                    icon:const Icon(Icons.arrow_back,size: 30,))  ,
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                   shadowColor: Colors.grey,
                          actions: [IconButton(onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute( builder:(_)=>const CartScreen()));
                          }, icon: SvgPicture.string(APPSVG.cartIcon))],
                          expandedHeight: 133.h,
                          pinned: true,
                          floating: true,
                          snap: true,
                          flexibleSpace:FlexibleSpaceBar(
                    background: Padding(
                          padding: const EdgeInsets.symmetric(vertical:20,horizontal: 15),
                      child: Builder(
                        builder: (ctx) {
                          return GetBuilder<ServiceController>(
                            init: ServiceController(),
                            builder: (controller) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                   SearchInput(controller: controller.searchController,onChanged: (v){
                                    controller.filterService(v);
                                  },),
      
                                
                                ],
                              );
                            }
                          );
                        }
                      ),
                    ),
                  ),
                  ),   
                  SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
                  sliver:GetBuilder(
                      init: ServiceController(),
                      id: ControllerID.SERVICE_FILTER,
                      builder: (controller) {
                        return SliverList.builder(
                            itemCount: controller.filtredServices.length,
                            itemBuilder: (_,index) {
                              final user= controller.users.firstWhere((element) => element.id==controller.filtredServices[index].userId);
                              String? img = controller.filtredServices[index].images.isEmpty?null:controller.filtredServices[index].images[0];
                              return InkWell(
                                onTap: (){
                                  controller.selectedServiceId=controller.filtredServices[index].id!;
                                  print(   controller.selectedServiceId=controller.filtredServices[index].id!);
                                   Navigator.of(context).push(MaterialPageRoute( builder:(_)=>const ProfessionalProfileScreen()));

                                },
                                child: ServiceItem(image:img,
                                                           firstName: user.firstName, 
                                                           lastName: user.lastName,
                                address: user.address!),
                              );
                            }
                            
                            
                            );
                      }
                    ) ,
      ) ,
          const  SliverToBoxAdapter(
                        child: SizedBox(height: 90),
                      )
                    
                                  
            ],
          );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
         
        }
      ),
    ));
  }
}