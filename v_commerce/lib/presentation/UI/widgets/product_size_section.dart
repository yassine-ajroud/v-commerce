import 'package:flutter/material.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/product_size_widget.dart';

class ProductSizeSection extends StatelessWidget {
  final double? height;
  final double? width;
  final double? thickness;
  const ProductSizeSection({super.key,this.height,this.thickness,this.width});

  @override
  Widget build(BuildContext context) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
       height!=null? ProductSizeWidget(icon: APPSVG.heightIcon,title: "Height",value: height!,):Container(),
       width!=null? ProductSizeWidget(icon: APPSVG.widthIcon,title: "Width",value: width!,):Container(),
       thickness!=null? ProductSizeWidget(icon: APPSVG.thicknessIcon,title: "Thickness",value: thickness!,):Container(),
    
        ].whereType<ProductSizeWidget>().toList(),
      );
  }
}
