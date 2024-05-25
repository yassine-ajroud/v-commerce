import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/service_category.dart';
import 'package:v_commerce/domain/usecases/service_category_usecases/get_servive_categories.dart';

class ServiceCategoryController extends GetxController{
    List<ServiceCategory> serviceCategoriesList=[];
    List<ServiceCategory> filtredServiceCategoriesList=[];

   TextEditingController searchController = TextEditingController(); 

 Future<List<ServiceCategory>> getServiceCategories()async{ 
          final res = await GetAllServiceCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        serviceCategoriesList=r;
        filtredServiceCategoriesList=r;
    });
    return serviceCategoriesList;
  }

void filterServiceCategories(String word){
    filtredServiceCategoriesList= serviceCategoriesList.where((element) => (element.title.toUpperCase().contains(word.toUpperCase()))).toList();
  
    update([ControllerID.SERVICE_CATEGORY_FILTER]);
}

  String serviceTitle(String id)=>serviceCategoriesList.firstWhere((element) => element.id==id).title;

  @override
  void onInit() {
    getServiceCategories();
    super.onInit();
  }
}