import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/presentation/UI/screens/payment/payment_address_screen.dart';
import 'package:v_commerce/presentation/UI/widgets/cart_item.dart';
import 'package:v_commerce/presentation/UI/widgets/checkout_button.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final AuthenticationController authenticationController=Get.find();

    return  SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: CartController(),
        id: ControllerID.SALE_QUANTITY,
        builder: (controller) {
          return FutureBuilder(
            future: controller.getUserCart(authenticationController.currentUser.id!),
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
                    icon:const Icon(Icons.arrow_back,size: 30,)) ,
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                       shadowColor: Colors.grey,
                              pinned: true,
                              floating: true,
                              snap: true,
                      ),  
                         const  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                    controller.cartSales.isNotEmpty?  SliverList.builder(
                        itemCount: controller.cartSales.length,
                        itemBuilder: (_,index)=> CartItem(sale: controller.cartSales[index], lastItem: index== controller.cartSales.length-1)):
                             const  SliverToBoxAdapter(
                    child: Center(child: Text("Empty Cart")),
                  ),
                          SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 40),
                      child: Column(
                                      children:[   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text("Frais d'expédition :",style: AppTextStyle.smallBlackTitleTextStyle,),
                          Text("${controller.shipping_fee}DT",style: AppTextStyle.blackTitleTextStyle,),
                        ],),
                           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text("Total :",style: AppTextStyle.smallBlackTitleTextStyle,),
                          Text('${(controller.totalPrice).toString()}DT',style: AppTextStyle.blackTitleTextStyle,),
                        ],),
                       const SizedBox(height: 10,),
                        CheckoutButton( click: (){
                          if(controller.currentCart.productsId.isNotEmpty){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PaymentAddressScreen()));

                          }

                        })
                                    ]),
                    ),
                  )
                ],
              );
              }else{
                return const Center(child:  CircularProgressIndicator());
              }


              
            }
          );
        }
      ),
    ));
  }
}