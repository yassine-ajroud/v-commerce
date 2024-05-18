import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:v_commerce/core/styles/colors.dart';
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
                        itemBuilder: (_,index)=>Container(child:Text(index.toString()))):
                             const  SliverToBoxAdapter(
                    child: Center(child: Text("Empty Cart")),
                  ),
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