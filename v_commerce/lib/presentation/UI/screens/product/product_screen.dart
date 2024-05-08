import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/supplier_controller.dart';
import 'package:o3d/o3d.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (pc) {
            return FutureBuilder(
              future: pc.getProductsById(pc.currentProductid),
              builder:(_,snapshot) {
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
                    icon: Icon(Icons.arrow_back,size: 30,)) ,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                   shadowColor: Colors.grey,
                      actions: [IconButton(
                                            padding: EdgeInsets.zero,

                        onPressed: (){}, icon: Icon(Icons.favorite_border,size: 30,))],
                      pinned: true,
                      floating: true,
                      snap: true,
                          
                  ),  
                          
                          
                    SliverToBoxAdapter(
                      child:Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<SupplierController>(
                              init: SupplierController(),
                              builder: (supplierController) {
                                return FutureBuilder(
                                  future:supplierController.getSupplierById(snapshot.data!.provider) ,
                                  builder:(_,snap){
                                      if(snap.hasData){
                                        return  Text(snap.data!.marque,style: AppTextStyle.greyTitleTextStyle,);
                                      }  else if(snapshot.connectionState==ConnectionState.waiting)  {
                                        return const Center(child:CircularProgressIndicator());
                                  
                                }else{
                                return  Container(width: 100,height: 20,color: AppColors.lightgrey,);
                               }
                                  } );
                              }
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: SizedBox(
                                                    height: 220.h,
                                                    child:Stack(
                                                      children: [
                              O3D.network(
                                backgroundColor: AppColors.lightgrey,
                               src:pc.productColors[1].model3D,
                                                  ),
                                                  Positioned(
                                                    right: 15.w,
                                                    bottom: 15.w,
                                                    child: Container(
                              decoration:const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 2,offset: Offset(0, 2))],
                              ),
                                                      child: InkWell(
                                                        onTap: (){},
                                                        child: CircleAvatar(radius: 20.r,backgroundColor: AppColors.primary,child:  SvgPicture.string(APPSVG.arIcon,width: 20.r,),))))
                                                      ],
                                                    ), ),
                            ),
 SizedBox(
  height: 50.h,
  width: 250.w,
   child: ListView.builder(
                              padding:const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: pc.productColors.length,
                              itemBuilder: (context, index) {
                                return Container(width: 20,height:20, color: AppColors.lightgrey,child: Image.network(pc.productColors[index].texture),);
                              },
                            ),
 ),

                       Text(snapshot.data!.name,style: AppTextStyle.greyTitleTextStyle,)//The 3D viewer widg
                          ],
                        ),
                      ) ,
                    )    ,
                          
                  
                ]
              );
}   else if(snapshot.connectionState==ConnectionState.waiting)  {
                                  return const Center(child:CircularProgressIndicator());
        
                          }else{
                          return const Text('error2');
                         }


              },
            );
          }
        ),
      ),
    );
  }
}