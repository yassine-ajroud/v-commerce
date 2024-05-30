import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/domain/entities/sales.dart';
import 'package:v_commerce/presentation/UI/screens/product/product_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/quantity_button.dart';
import 'package:v_commerce/presentation/controllers/cart_controller.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartItem extends StatelessWidget {
  final Sales sale;
    final bool lastItem;
  const CartItem({super.key,required this.sale,required this.lastItem});

  @override
  Widget build(BuildContext context) {
                      ProductController productController = Get.find();
    return GetBuilder(
      init: CartController(),
              id: ControllerID.SALE_QUANTITY,
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                   InkWell(
                        onTap: ()async{
                         controller.deleteSale(sale.id!);
                        },
                        child: SvgPicture.string(APPSVG.trashIcon)),
                    
                 
                  const SizedBox(width: 10,),
                   InkWell(
                    onTap: (){
                      productController.currentProductid=sale.productId;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductScreen()));
                    },
                     child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(controller.cartProducts.firstWhere((element) => element.id==sale.modelId).texture,height: 80.h,width: 80.w,fit: BoxFit.cover,)),
                   ),
                            const SizedBox(width: 10,),
                   SizedBox(
                    width: 120.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(productController.allProducts.firstWhere((element) => element.id==sale.productId).name,style: AppTextStyle.smallBlackTitleTextStyle,overflow: TextOverflow.visible,),
                        const SizedBox(height: 10,),
                        Text('${sale.totalPrice}${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.blackTitleTextStyle,overflow: TextOverflow.visible,),
                      ],
                    )),
                                            QuantityButton(backgroundColor: AppColors.lightgrey, icon: Icons.remove, onPress: ()async{
                                                await controller.decrimentSaleQuantity(sale.id!);
                                            }, color: AppColors.primary),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(sale.quantity.toString(),style: AppTextStyle.blackTextStyle,),
                                            ),
                                            QuantityButton(backgroundColor: AppColors.lightgrey, icon: Icons.add, onPress: ()async{
                                                  await controller.incrementSaleQuantity(sale.id!);

                                            }, color: AppColors.primary)

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
    );
  }
}