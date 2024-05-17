import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/sub_catergory.dart';
import 'package:v_commerce/domain/usecases/category_usecases/get_categories_usecase.dart';

import '../../domain/entities/category.dart';

class CategoryController extends GetxController{
  List<Category> categoriesList=[];
  List<SubCategory> subCategoriesList=[];
   List<Category> filtredCategoriesList=[];
 late  Category selectedCategory;
   TextEditingController searchController = TextEditingController(); 


  Future<List<Category>> getAllCategories()async{ 
    final res = await GetAllCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        filtredCategoriesList=r;
      return categoriesList=r;
    });

    categoriesList.insert(0,const Category(id: "all", title: "tous", image: 'https://www.sm-devis.tn/wp-content/uploads/2019/11/Prix-de-la-pose-de-carrelage-en-Tunisie.jpg'));
    selectedCategory = categoriesList[0];
    return categoriesList;
  }

void filterCategories(String word){
      List<Category> prd=categoriesList;
    print(filtredCategoriesList);
    filtredCategoriesList= prd.where((element) => (element.title.toUpperCase().contains(word.toUpperCase()))).toList();
    update([ControllerID.CATEGORY_FILTER]);
}

  void selectCategory(Category category){
    selectedCategory = category;
    update([ControllerID.SELECT_CATEGORY]);

  }

  @override
  void onInit() async{
    super.onInit();
  await getAllCategories();
  }
}