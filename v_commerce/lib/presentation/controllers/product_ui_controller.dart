import 'package:get/get.dart';
import 'package:v_commerce/core/utils/string_const.dart';

class ProductUiController extends GetxController{
    bool expandedSize=false;
  bool expandedMaterials=false;

  void toggleSizeExpandable(bool value){
    expandedSize = value;
    update([ControllerID.PRODUCT_SIZE_TOGGLE]);
  }
  void toggleMaterialsExpandable(bool value){
    expandedMaterials = value;
    update([ControllerID.PRODUCT_MATERIALS_TOGGLE]);
  }
}