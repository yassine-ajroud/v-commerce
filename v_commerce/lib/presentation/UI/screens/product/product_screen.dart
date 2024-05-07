import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';
import 'package:v_commerce/presentation/controllers/supplier_controller.dart';

class ProductScreen extends StatelessWidget {
  final String productId;
  const ProductScreen({super.key,required this.productId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (pc) {
            return FutureBuilder(
              future: pc.getProductsById("6636aca6f868771a2dbbf553"),
              builder:(_,snapshot) {
                print(snapshot.data);
        if(snapshot.hasData){
          final prod = snapshot.data;
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
                        padding: const EdgeInsets.symmetric(horizontal:15.0),
                        child: GetBuilder<SupplierController>(
                          init: SupplierController(),
                          builder: (supplierController) {
                            return FutureBuilder(
                              future:supplierController.getSupplierById("6637c13ac5261ca30065839d") ,
                              builder:(_,snap){
                                  if(snap.hasData){
                                    return  Text(snap.data!.marque,style: AppTextStyle.greyTitleTextStyle,);
                                  }  else if(snapshot.connectionState==ConnectionState.waiting)  {
                                    return const Center(child:CircularProgressIndicator());
                              
                            }else{
                            return const Text('error1');
                           }
                              } );
                          }
                        ),
                      ) ,
                    )    ,
                          
                    
                   SliverToBoxAdapter(
                    child: Container()//The 3D viewer widget
                  )
                          
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