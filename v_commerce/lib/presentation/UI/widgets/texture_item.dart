import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';

import '../../../domain/entities/product3d.dart';

class TextureItem extends StatelessWidget {
  final Product3D product;
  const TextureItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      id:ControllerID.PRODUCT_TEXTURE,
      builder: (controller) {
       final isSelected = controller.selected3Dproduct.id==product.id;
        return InkWell(
          onTap: (){
            controller.selectTexture(product);
          },
          child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(isSelected?13:10),
                                            border:isSelected? Border.all(color: AppColors.black,width: 4):null
                                          ),
                                          width:isSelected?50.w:45.w,height:isSelected? 60.h: 50.h,child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(product.texture,fit: BoxFit.cover,)),),
                                      ),
        );
      }
    );
  }
}