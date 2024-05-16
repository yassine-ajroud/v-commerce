import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/favourite_item.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/drawerController.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/wishlist_controller.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController=Get.find();
    final ProductController productController=Get.find();
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: WishListController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getUserWishlist(authenticationController.currentUser.id!),
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
                              actions: [IconButton(onPressed: (){}, icon: SvgPicture.string(APPSVG.cartIcon))],
                              pinned: true,
                              floating: true,
                              snap: true,
                      ),  
                         const  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                    controller.wishlistModel.isNotEmpty?  SliverList.builder(
                        itemCount: controller.wishlistModel.length,
                        itemBuilder: (_,index)=>FavouriteItem(texture:controller.wishlistModel[index] ,image: controller.wishlistModel[index].texture, label:productController.allProducts.firstWhere((element) => element.id== controller.wishlistModel[index].product).name, price: productController.getPrice(productController.allProducts.firstWhere((element) => element.id== controller.wishlistModel[index].product)),
                        liked: controller.getWishlistIds.contains(controller.wishlistModel[index].id),
                        lastItem: index==controller.wishlistModel.length-1,)):
                             const  SliverToBoxAdapter(
                    child: Center(child: Text("Empty Wishlist")),
                  )
                         ,
                        const  SliverToBoxAdapter(
                    child: SizedBox(height: 90),
                  )
                ],
              );
              }else{
                return const CircularProgressIndicator();
              }


              
            }
          );
        }
      ),
    ));
  }
}