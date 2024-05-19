import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/core/utils/enums.dart';
import 'package:v_commerce/core/utils/string_const.dart';

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

}