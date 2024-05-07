import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/product.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_one_product_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_products_by_category_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_sorted_products_usecase.dart';

class ProductController extends GetxController {
  List<Product> allProducts=[];
  List<Product> sortedProducts=[];
  List<Product> filtredProducts=[];
  List<Product> productsByCategory=[];
  late Product currentProduct;
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

  
Future<bool> getProductsById(String id)async{ 
   Product? prod;
     final res = await GetOneProductsUsecase(sl())(id);
    res.fold((l) => null, (r) => currentProduct=r);
   //update();
    return true;
  }

  void filterProducts(String word){
    List<Product> prd=allProducts;
   
    filtredProducts= prd.where((element) => (element.name.toUpperCase().contains(word.toUpperCase()))).toList();
    print('all prods $allProducts');
   print(word.toUpperCase());
    print("filtred $filtredProducts");
    update([ControllerID.PRODUCT_FILTER]);
  }
 @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
  await getAllProducts();
  productsByCategory=allProducts;
  }
}