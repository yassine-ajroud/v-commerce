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
    List<Category> allCategories=[];
   List<Category> filtredCategoriesList=[];
 late  Category selectedCategory;
   TextEditingController searchController = TextEditingController(); 
final all=const Category(id: "all", title: "tous", image: 'https://www.sm-devis.tn/wp-content/uploads/2019/11/Prix-de-la-pose-de-carrelage-en-Tunisie.jpg');

  Future<List<Category>> getAllCategories()async{ 
    if(categoriesList.isEmpty){
          final res = await GetAllCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        filtredCategoriesList=r;
       categoriesList=r;
    });
    categoriesList.insert(0,all);
    selectedCategory = all;
    return categoriesList;
    }else{
      
      return categoriesList;
    }

  }

    Future<List<Category>> getCategories()async{ 
          final res = await GetAllCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        allCategories=r;
        filtredCategoriesList=r;
    });
    return filtredCategoriesList;
  }

void filterCategories(String word){
    filtredCategoriesList= allCategories.where((element) => (element.title.toUpperCase().contains(word.toUpperCase()))).toList();
                        filtredCategoriesList.remove(all);

    update([ControllerID.CATEGORY_FILTER]);
}

  void selectCategory(Category category){
    selectedCategory = category;
    update([ControllerID.SELECT_CATEGORY]);
  }

  @override
  void onInit() async{
    super.onInit();
    if(categoriesList.isEmpty){
      selectedCategory=all;
  await getAllCategories();

    }
  }
}