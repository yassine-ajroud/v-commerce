import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/cart.dart';
import 'package:v_commerce/domain/entities/sales.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/get_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/add_sale_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/delete_sale_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/get_single_sale_usecase.dart';

class CartController extends GetxController{
late  Cart currentCart;
List<Sales> cartSales=[];

Future<Cart> getUserCart(String userId)async{

 final res= await GetCartUsecase(sl())(userId: userId);
 res.fold((l) => null, (r) =>currentCart=r );
 await getCartSales();
 return currentCart;
}

Future<void> addUserCart(String userId)async{
 await CreateCartUsecase(sl())(userId: userId);
}

Future<void> updateUserCart(Cart newCart)async{
 await UpdateCartUsecase(sl())(cart: newCart);
}

Future<List<Sales>> getCartSales()async{
  cartSales=[];
  for (var element in currentCart.productsId) {
   final  res = await GetSingleSalesUsecase(sl())(element);
   res.fold((l) => null, (r) => cartSales.add(r)); 
  }
  return cartSales;
}


 List<String> get getCartSalesId=> cartSales.map((e) => e.id!).toList();

 
 Future addSale(Sales newSale)async{
  if(!getCartSalesId.contains(newSale.productId)){
    final addsale = await AddSaleUsecase(sl()).call(newSale);
    addsale.fold((l) => null, (r) async{
      cartSales.add(r);
      await _updateSailes();
    });
  }else{
     Fluttertoast.showToast(
            msg: 'product already in cart!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            fontSize: 16.0);
  }
 }


Future _updateSailes()async{
          currentCart.productsId=getCartSalesId;

  final rs = await UpdateCartUsecase(sl()).call(cart: currentCart);
    rs.fold((l) => null, (r)  async {
    });
    update();
}

Future deleteSale(String saleId)async{
  await DeleteSaleUsecase(sl()).call(saleId); 
  cartSales.removeWhere((element) => element.id==saleId);
  await _updateSailes();

  update();
}


}