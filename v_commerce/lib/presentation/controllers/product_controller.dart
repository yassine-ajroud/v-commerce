import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/product.dart';
import 'package:v_commerce/domain/usecases/product_3d_usecases/get_all_3d_products_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_one_product_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_products_by_category_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_sorted_products_usecase.dart';

import 'package:v_commerce/domain/entities/product3d.dart';

class ProductController extends GetxController {
  List<Product> allProducts=[];
  List<Product> sortedProducts=[];
  List<Product> filtredProducts=[];
  List<Product> productsByCategory=[];
  List<Product3D> productColors=[];
  late Product currentProduct;
  late Product3D selected3Dproduct;
  String currentProductid="";
  int quantity=1;
  UniqueKey textureKey=UniqueKey();
  TextEditingController searchController = TextEditingController(); 
  

  Future<List<Product>> getAllProducts()async{ 
    final res = await GetAllProductsUsecase(sl())();
    res.fold((l) => null, (r) => allProducts=r);
    productsByCategory=allProducts;
    return allProducts;
  }

  Future<List<Product>> getSortedProducts()async{ 
     final res = await GetSortedProductsUsecase(sl())();
    res.fold((l) => null, (r) => sortedProducts=r);
    return sortedProducts;
  }

  Future<List<Product>> getProductsByCategory(String category)async{ 
    if(category=="all"){
        productsByCategory=allProducts;
      return productsByCategory;
    }
     final res = await GetProductsByCategoryUsecase(sl())(category);
    res.fold((l) => null, (r) => productsByCategory=r);
    return productsByCategory;
  }

set setProductId(String id)=>currentProductid =id;
  
Future<Product?> getProductsById(String id)async{ 
     final res = await GetOneProductsUsecase(sl())(id);
     final txtr= await GetAll3DProductsUseCase(sl()).call(id);
    res.fold((l) => null, (r) => currentProduct=r);
    txtr.fold((l) => null, (r) => productColors = r);
     quantity=1;
    selected3Dproduct=productColors[0];
    return currentProduct;
  }

void selectTexture(Product3D new3DProduct){
  selected3Dproduct=new3DProduct;
  textureKey = UniqueKey();
  update([ControllerID.PRODUCT_TEXTURE]);
}

  void filterProducts(String word){
    List<Product> prd=allProducts;
    filtredProducts= prd.where((element) => (element.name.toUpperCase().contains(word.toUpperCase()))).toList();
    update([ControllerID.PRODUCT_FILTER]);
  }
 @override
  void onInit() async{
    super.onInit();
  await getAllProducts();
  productsByCategory=allProducts;
  }

  void incrementQuantity(){
    if(quantity<selected3Dproduct.quantity){
   quantity++;
  update([ControllerID.PRODUCT_TEXTURE]);
    }

  }
    void decrementQuantity(){
  if(quantity>1){
   quantity--;
  update([ControllerID.PRODUCT_TEXTURE]);
    }
}

}