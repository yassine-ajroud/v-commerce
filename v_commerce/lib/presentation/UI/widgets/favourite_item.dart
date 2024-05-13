import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/domain/entities/product3d.dart';
import 'package:v_commerce/presentation/UI/screens/product/product_screen.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/wishlist_controller.dart';

// ignore: must_be_immutable
class FavouriteItem extends StatelessWidget {
  final String image;
  final String label;
  final double price;
   bool liked;
  final bool lastItem;
  final Product3D texture;
   FavouriteItem({super.key,required this.image,required this.label,required this.price,required this.liked,required this.lastItem,required this.texture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder(
                init: WishListController(),
                id: ControllerID.LIKE_PRODUCT,
                builder: (controller) {
                  return InkWell(
                    onTap: ()async{
                     await controller.toggleLikedTexture(texture);
                     liked = controller.likedProduct(texture.id);
                    },
                    child: SvgPicture.string(liked?APPSVG.selectedWishlistIcon: APPSVG.wishlistIcon));
                }
              ),
              const SizedBox(width: 10,),
               InkWell(
                onTap: (){
                  ProductController productController = Get.find();
                  productController.currentProductid=texture.product;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductScreen()));
                },
                 child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(image,height: 100.h,width: 100.w,fit: BoxFit.cover,)),
               ),
                        const SizedBox(width: 10,),
               SizedBox(
                width: 180.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label,style: AppTextStyle.smallBlackTitleTextStyle,overflow: TextOverflow.visible,),
                    const SizedBox(height: 10,),
                    Text('${price.toString()}DT',style: AppTextStyle.blackTitleTextStyle,overflow: TextOverflow.visible,),

                  ],
                ))
            ],
          ),
         lastItem?Container(): const Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.0),
            child:  Divider(),
          )
        ],
      ),
    );
  }
}

