import 'dart:math';

import 'package:get/get.dart';
import 'package:v_commerce/core/utils/enums.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/reclamation.dart';
import 'package:v_commerce/domain/usecases/reclamation_usecases/add_reclamation_usecase.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/cart_controller.dart';

class PaymentController extends GetxController{
   String adres='';
   String gov='';
   String ville='';
   String code='';
   String phone='';
   PaymentMethod paymentMethod=PaymentMethod.cash;

  void getUserAddress(String address,String gouvernorat,String ville,String code,String phone,){
    adres=address;
    gov=gouvernorat;
    ville=ville;
    code=code;
    phone=phone;
  }

  void setPaymentMethod(PaymentMethod method){
    paymentMethod=method;
    update([ControllerID.PAYMENT_METHOD]);
  }

  Future<bool> createOrder()async{
    bool success=false;
    final AuthenticationController authenticationController=Get.find();
    final CartController cartController=Get.find();
    final res = await AddReclamationsUsecase(sl())(Reclamation(user: authenticationController.currentUser.id!, sales: cartController.getCartSalesId, reference: generateReference(11), price: cartController.totalPrice,
    address: '$gov-$adres$ville$code'
    ));
    res.fold((l) => null, (r)async {
      await cartController.clearCart();
      success=true;
    });
    return success;
  }

  String generateReference(int length) {
  const String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  Random random = Random();
  String ref = '';

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(charset.length);
    ref += charset[randomIndex];
  }

  return ref;
}
}