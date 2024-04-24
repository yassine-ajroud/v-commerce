import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/promotion.dart';
import 'package:v_commerce/domain/usecases/promotion_usecases/get_all_promotions_usecase.dart';

class PromotionController extends GetxController {
  List<Promotion> promotionsList=[];

  Future<List<Promotion>> getAllPromotions()async{
    final res = await GetAllPromotionsUsecase(sl())();
    res.fold((l) => null, (r) => promotionsList=r);
    return promotionsList;
  }

}