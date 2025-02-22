import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/cart/cart_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/search_input.dart';
import 'package:v_commerce/presentation/UI/widgets/service_category_item.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/service_category_controller.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceCategoryController categoryController=Get.find();

    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: FutureBuilder(
        future: categoryController.getServiceCategories(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
 return CustomScrollView(
            slivers: [
                      SliverAppBar(
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
                          return GetBuilder<ServiceCategoryController>(
                            init: ServiceCategoryController(),
                            builder: (controller) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                   SearchInput(controller: controller.searchController,onChanged: (v){
                                    controller.filterServiceCategories(v);
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
                      init: ServiceCategoryController(),
                      id: ControllerID.SERVICE_CATEGORY_FILTER,
                      builder: (controller) {
                        return SliverList.builder(
                            itemCount: controller.filtredServiceCategoriesList.length,
                            itemBuilder: (_,index)=>ServiceCategoryItem(id:controller.filtredServiceCategoriesList[index].id ,image: controller.filtredServiceCategoriesList[index].image, title: controller.filtredServiceCategoriesList[index].title));
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