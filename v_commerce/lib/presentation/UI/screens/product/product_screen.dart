import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:v_commerce/core/l10n/plural_strings.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/domain/entities/sales.dart';
import 'package:v_commerce/presentation/UI/screens/augmented_reality/ar_objects_screen.dart';
import 'package:v_commerce/presentation/UI/screens/product/filtered_product_screen.dart';
import 'package:v_commerce/presentation/UI/screens/product/review_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/button.dart';
import 'package:v_commerce/presentation/UI/widgets/expandable_header.dart';
import 'package:v_commerce/presentation/UI/widgets/product_size_section.dart';
import 'package:v_commerce/presentation/UI/widgets/products_item.dart';
import 'package:v_commerce/presentation/UI/widgets/quantity_button.dart';
import 'package:v_commerce/presentation/UI/widgets/rating_section.dart';
import 'package:v_commerce/presentation/UI/widgets/texture_item.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/cart_controller.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/product_ui_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import 'package:v_commerce/presentation/controllers/rating_controller.dart';
import 'package:v_commerce/presentation/controllers/supplier_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:o3d/o3d.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/controllers/wishlist_controller.dart';

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
                      actions: [GetBuilder(
                        init: ProductController(),
                        id:ControllerID.PRODUCT_TEXTURE,
                        builder: (context) {
                          return GetBuilder(
                            init: WishListController(),
                            id:ControllerID.LIKE_PRODUCT,
                            builder: (wishListController) {
                              return IconButton(
                                                    padding: EdgeInsets.zero,

                                onPressed: ()async{
                               await   wishListController.toggleLikedTexture(pc.selected3Dproduct);
                                }, icon:  SvgPicture.string((wishListController.likedProduct(pc.selected3Dproduct.id) ?APPSVG.selectedWishlistIcon: APPSVG.wishlistIcon)));
                            }
                          );
                        }
                      )],
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
                                   // backgroundColor: AppColors.lightgrey,
                                   src:controller3d.selected3Dproduct.model3D,
                                                      ),
                                                      Positioned(
                                                        right: 15.w,
                                                        bottom: 15.w,
                                                        child: FloatingActionButton(
                                                          backgroundColor: AppColors.primary,
                                                          shape:const CircleBorder(),
                                                          onPressed: (){
                                                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ObjectGesturesWidget(models: [controller3d.selected3Dproduct],isSingleProduct: true,)));
                                                          },
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
      height: 65.h,
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
                                               return Text("${snapshot.data.toString()}${AppLocalizations.of(context)!.dinar}",style: AppTextStyle.mainPriceTextStyle,);
                                              }return const SizedBox();
                                            }
                                          ),
                                          const SizedBox(width: 10,),
                                          Text('${pc.currentProduct.price}${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.oldPriceTextStyle,)
                                          ],);
                                           
                                        }
                                      ):Expanded(child: Center(child: Text('${pc.currentProduct.price}${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.mainPriceTextStyle,))),

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
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(pc.currentProduct.description,style: AppTextStyle.descriptionTextStyle,),
                ),
                GetBuilder<ProductUiController>(
                  init: ProductUiController(),
                  id: ControllerID.PRODUCT_SIZE_TOGGLE,
                  builder: (sizeController) {
                    return ExpandableHeader(
                      title: AppLocalizations.of(context)!.product_size,
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
                const SizedBox(height: 10,),
                GetBuilder<ProductUiController>(
                  init: ProductUiController(),
                  id: ControllerID.PRODUCT_MATERIALS_TOGGLE,
                  builder: (materialController) {
                    return ExpandableHeader(
                      title: AppLocalizations.of(context)!.used_materials,
                      icon: APPSVG.materialIcon,
                      onPress: (){
                        materialController.toggleMaterialsExpandable(!materialController.expandedMaterials);
                      },
                      expanded: materialController.expandedMaterials,
                    );
                  }
                ),
                GetBuilder<ProductUiController>(
                  init: ProductUiController(),
                  id: ControllerID.PRODUCT_MATERIALS_TOGGLE,
                  builder: (materialController) {
                    return ExpandablePanel(
                                        controller: ExpandableController()..expanded=materialController.expandedMaterials,
                                        collapsed: Container(),
                                        expanded:
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(pc.currentProduct.materials,style: AppTextStyle.descriptionTextStyle,),
                                        )
                                        );
                  }
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: GetBuilder<RatingController>(
                    init:RatingController(),
                    builder: (controller) {
                      return FutureBuilder(
                        future: controller.getRating(pc.currentProductid),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return const RatingSection();
                          }else{
                            return const CircularProgressIndicator();
                          }

                          
                        }
                      );
                    }
                  ),
                ),
                 Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),

                   child: Row(
                                mainAxisSize: MainAxisSize.max,
                           
                                children: [
                               const Expanded(child: Divider(color: AppColors.black,thickness: 1)),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppColors.backgroundWhite),
                                    overlayColor: MaterialStateProperty.all(AppColors.backgroundWhite),
                                    surfaceTintColor: MaterialStateProperty.all(AppColors.backgroundWhite),
                                    foregroundColor:MaterialStateProperty.all(AppColors.secondary), 
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(18.0),
                       side:const BorderSide(color:AppColors.secondary,width: 2)
                     )
                   )
                 ),
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ReviewScreen()));

                                  }, child:Text.rich( TextSpan(children:[TextSpan(text:AppLocalizations.of(context)!.view_comments,style: AppTextStyle.smallBlueTitleTextStyle),WidgetSpan(child: Icon(Icons.arrow_forward),alignment: PlaceholderAlignment.middle,) ]),textAlign: TextAlign.center,),
                        ),
                                  const Expanded(child: Divider(color: AppColors.black,thickness: 1)),
                 
                              ],),
                 ),
                 Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                   child: GetBuilder(
                    init: CartController(),
                     builder: (cartController) {
                       return MyButton(text: AppLocalizations.of(context)!.add_to_cart, click: ()async{
                        final AuthenticationController authenticationController=Get.find();
                        cartController.addSale(Sales(status: [], modelId: pc.selected3Dproduct.id, productId: pc.currentProductid, providerId: pc.currentProduct.provider, userId: authenticationController.currentUser.id!,
                         quantity: pc.quantity, totalPrice: pc.quantity*pc.getPrice(pc.currentProduct)));
                       });
                     }
                   ),
                 ),
                 Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(AppLocalizations.of(context)!.similar_products,style: AppTextStyle.blackTitleTextStyle,),InkWell(
                              onTap:(){
                           Navigator.of(context).push(MaterialPageRoute(builder: (_)=>FilteredProductScreen(products:pc.similarProducts)));
                            },
                            child: Text(AppLocalizations.of(context)!.see_all,style: AppTextStyle.hintTextStyle,)),
                                ]),
                                 SizedBox(
                                                                   height:   260.h,

                                   child: FutureBuilder(
                                                         future: pc.getProductsBySubCategory(pc.currentProduct.category,pc.currentProduct.subCategory,pc.currentProductid),
                                                         builder: (context, snapshot) {
                                                           if(snapshot.hasData&&pc.similarProducts.isNotEmpty){ 
                                                             return ListView.builder(
                                                             padding:const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                                             scrollDirection: Axis.horizontal,
                                                             itemCount: pc.similarProducts.length,
                                                             itemBuilder: (context, index) {
                                                               return InkWell(
                                                                 
                                                                 child: ProductItem(image:pc.similarProducts[index].image,
                                                                 name:pc.similarProducts[index].name ,
                                                                 price: pc.similarProducts[index].price,
                                                                 promo:pc.similarProducts[index].promotion ,
                                                                 id:pc.similarProducts[index].id! ,
                                                                 rating: pc.similarProducts[index].rate,
                                                                 ),
                                                               );
                                                             },
                                                           );
                                                           }else if(snapshot.connectionState==ConnectionState.waiting)  {
                                    return const Center(child:CircularProgressIndicator());
                                         
                                                           }else{
                                                           return  Center(child:  Text(AppLocalizations.of(context)!.no_similar_products));
                                                          }             
                                                         }
                                                       ),
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