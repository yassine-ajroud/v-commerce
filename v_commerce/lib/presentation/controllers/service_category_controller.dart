import 'package:get/get.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/service_category.dart';
import 'package:v_commerce/domain/usecases/service_category_usecases/get_servive_categories.dart';

class ServiceCategoryController extends GetxController{
    List<ServiceCategory> serviceCategoriesList=[];



 Future<List<ServiceCategory>> getServiceCategories()async{ 
          final res = await GetAllServiceCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        serviceCategoriesList=r;
    });
    return serviceCategoriesList;
  }
}