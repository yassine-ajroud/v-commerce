import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/l10n/plural_strings.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/expandable_header.dart';
import 'package:v_commerce/presentation/UI/widgets/product_size_section.dart';
import 'package:v_commerce/presentation/UI/widgets/quantity_button.dart';
import 'package:v_commerce/presentation/UI/widgets/texture_item.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/product_ui_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import 'package:v_commerce/presentation/controllers/supplier_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:o3d/o3d.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExpandableController expandableController = ExpandableController();
    expandableController.expanded=true;
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
                    icon:const Icon(Icons.arrow_back,size: 30,)) ,
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
                            GetBuilder(
                              init: ProductController(),
                              id: ControllerID.PRODUCT_TEXTURE,
                              builder: (controller3d) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: SizedBox(
                                                        height: 220.h,
                                                        child:Stack(
                                                          children: [
                                  O3D.network(
                                    key: controller3d.textureKey,
                                    backgroundColor: AppColors.lightgrey,
                                   src:controller3d.selected3Dproduct.model3D,
                                                      ),
                                                      Positioned(
                                                        right: 15.w,
                                                        bottom: 15.w,
                                                        child: FloatingActionButton(
                                                          backgroundColor: AppColors.primary,
                                                          shape:const CircleBorder(),
                                                          onPressed: (){},
                                                          child:  SvgPicture.string(APPSVG.arIcon,width: 20.r,),))
                                                          ],
                                                        ), ),
                                );
                              }
                            ),
 Row(
    mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: [
     Container(
      color: AppColors.lightgrey2,
      height: 70.h,
      width: 180.w,
       child: ListView.builder(
                                  padding:const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                  scrollDirection: Axis.horizontal,
                                //  shrinkWrap: true,
                                  itemCount: pc.productColors.length,
                                  itemBuilder: (context, index) {
                                    return TextureItem(product: pc.productColors[index]);
                                  },
                                ),
     ),
    pc.currentProduct.promotion? GetBuilder<PromotionController>(
                                        init: PromotionController(),
                                        builder: (promoController)  { 
                                          return Row(
                                            children: [ FutureBuilder(
                                            future:promoController.getPromotionPrice(pc.currentProduct.id!) ,
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                               return Text("${snapshot.data.toString()}DT",style: AppTextStyle.mainPriceTextStyle,);
                                              }return const SizedBox();
                                            }
                                          ),
                                          const SizedBox(width: 10,),
                                          Text('${pc.currentProduct.price}DT',style: AppTextStyle.oldPriceTextStyle,)
                                          ],);
                                           
                                        }
                                      ):Expanded(child: Center(child: Text('${pc.currentProduct.price}DT',style: AppTextStyle.mainPriceTextStyle,))),

   ],
 ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:20.0),
                    child: GetBuilder<ProductController>(
                      init: ProductController(),
                      id:ControllerID.PRODUCT_TEXTURE,
                      builder: (textureController) {
                        return Row(
                          children: [
                            PluralStrings.onOrder(textureController.selected3Dproduct.quantity,context),
                            const Spacer(),
                            QuantityButton(backgroundColor: AppColors.secondary, icon: Icons.remove, onPress: (){
                              textureController.decrementQuantity();
                            },color: AppColors.white,),
                            const SizedBox(width: 10,),
                            Text(textureController.quantity.toString(),style: AppTextStyle.blackTitleTextStyle,),
                            const SizedBox(width: 10,),
                  
                            QuantityButton(backgroundColor: AppColors.secondary, icon: Icons.add, onPress: (){
                                textureController.incrementQuantity();
                            },color: AppColors.white,)
                          ],
                        );
                      }
                    ),
                  ),
                Text(pc.currentProduct.name,style: AppTextStyle.boldBlackTitleTextStyle,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(pc.currentProduct.description,style: AppTextStyle.descriptionTextStyle,),
                ),
                const SizedBox(height: 10,),
                GetBuilder<ProductUiController>(
                  init: ProductUiController(),
                  id: ControllerID.PRODUCT_SIZE_TOGGLE,
                  builder: (sizeController) {
                    return ExpandableHeader(
                      title: "Product size",
                      icon: APPSVG.sizeIcon,
                      onPress: (){
                        sizeController.toggleSizeExpandable(!sizeController.expandedSize);
                      },
                      expanded: sizeController.expandedSize,
                    );
                  }
                ),
                GetBuilder<ProductUiController>(
                  init: ProductUiController(),
                  id: ControllerID.PRODUCT_SIZE_TOGGLE,
                  builder: (sizeController) {
                    return ExpandablePanel(
                                        controller: ExpandableController()..expanded=sizeController.expandedSize,
                                        collapsed: Container(),
                                        expanded:
                                        ProductSizeSection(height: pc.currentProduct.dimensions.height,width:pc.currentProduct.dimensions.width ,thickness: pc.currentProduct.dimensions.thickness,)
                                        );
                  }
                ),
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