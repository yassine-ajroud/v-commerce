import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/presentation/UI/screens/product/product_screen.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/promotion_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final double price;
  final bool promo; 
  final double rating;
  const ProductItem({super.key,required this.image,required this.name,required this.price, this.promo=false,required this.id,required this.rating});

  @override
  Widget build(BuildContext context) {
    int filledStar=rating.toInt();
    double fraction = rating-filledStar;
    bool halfStar=false;
    if(fraction>=0.3&&fraction<=0.7){
      halfStar=true;
    }else if(fraction>0.7){
      filledStar++;
    }
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) {
        return InkWell(
          onTap: (){
            controller.setProductId=id;
            Navigator.of(context).push(MaterialPageRoute( builder:(_)=>const ProductScreen()));
          },
          child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                              children: [
                                SizedBox(               
                                  width: 150.w,
                                  height: 170.h,
                                 child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(image,width: 150.w,height: 170.h,fit: BoxFit.cover,)),
                                ),
                                 Positioned(
                                  bottom:15,
                                  right:15,
                                   child: Container(               
                                    width: 30.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                       color: AppColors.primary,
                                       borderRadius: BorderRadius.circular(5)
                                     ),child:const Icon(Icons.add,color: AppColors.white,),  ),
                                 ),
                              ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(5, (index) => Icon(index<filledStar? Icons.star:
                                  halfStar&&index==filledStar?Icons.star_half :
                                  Icons.star_border,size: 20,color: AppColors.secondary,)),),
                              ),
        
                                 SizedBox(width: 145.w, child: Text(name,style: AppTextStyle.smallBlackTitleTextStyle, overflow: TextOverflow.ellipsis,  maxLines: 1,
          softWrap: false,)),
                                 Padding(
                                                             padding: const EdgeInsets.only(top:8.0),
        
                             
                                     child: promo?GetBuilder<PromotionController>(
                                        init: PromotionController(),
                                        builder: (promoController)  { 
                                          return Row(children: [ FutureBuilder(
                                            future:promoController.getPromotionPrice(id) ,
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                               return Text("${snapshot.data.toString()}${AppLocalizations.of(context)!.dinar}",style: AppTextStyle.priceTextStyle,);
                                              }return const SizedBox();
                                            }
                                          ),
                                          const SizedBox(width: 10,),
                                          Text('$price${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.oldPriceTextStyle,)
                                          ],);
                                           
                                        }
                                      ):Text('$price${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.priceTextStyle,),
                                    
                                 )
        
                            ],
                          )
                        ),
        );
      }
    );
  }
}