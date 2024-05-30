import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/cart.dart';
import 'package:v_commerce/domain/entities/product3d.dart';
import 'package:v_commerce/domain/entities/sales.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/get_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/product_3d_usecases/get_3d_product_by_id_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/add_sale_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/delete_sale_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/get_single_sale_usecase.dart';
import 'package:v_commerce/domain/usecases/sales_usecases/update_sale_usecase.dart';
import 'package:v_commerce/presentation/controllers/product_controller.dart';

class CartController extends GetxController{
late  Cart currentCart;
List<Sales> cartSales=[];
List<Product3D> cartProducts=[];
double totalPrice=0.0;
var shipping_fee=40.0;


Future<Cart> getUserCart(String userId)async{
cartSales=[];
cartProducts=[];
 final res= await GetCartUsecase(sl())(userId: userId);
 res.fold((l) => null, (r) =>currentCart=r );
 await getCartSales();
 print('all sales $cartSales');
 await getCartProducts();
 getReclamationPrice();
 return currentCart;
}

Future<void> getCartProducts()async{
  cartProducts=[];
  print("cart $cartSales");
  for (var element in cartSales) {
    final res = await Get3DProductsByIdUseCase(sl())(element.modelId);
    res.fold((l) => null, (r) => cartProducts.add(r));
  }
}

Future<void> incrementSaleQuantity(String saleId)async{
  final ProductController productController = Get.find();
final Sales sale=cartSales.firstWhere((element) => element.id==saleId);
  if(sale.quantity<cartProducts.firstWhere((element) => sale.modelId==element.id).quantity){
  sale.quantity++;
    sale.totalPrice=double.parse( (productController.getPrice(productController.allProducts.firstWhere((element) => element.id==sale.productId))*sale.quantity).toStringAsFixed(2)) ;
  await UpdateSaleUsecase(sl())(sale);
  }
   getReclamationPrice();
  update([ControllerID.SALE_QUANTITY]);
}
Future<void> decrimentSaleQuantity(String saleId)async{
  final ProductController productController = Get.find();

final Sales sale=cartSales.firstWhere((element) => element.id==saleId);
  if(sale.quantity>1){
  sale.quantity--;
    sale.totalPrice=double.parse( (productController.getPrice(productController.allProducts.firstWhere((element) => element.id==sale.productId))*sale.quantity).toStringAsFixed(2)) ;
  await UpdateSaleUsecase(sl())(sale);
  }
   getReclamationPrice();

  update([ControllerID.SALE_QUANTITY]);
}

Future<void> addUserCart(String userId)async{
 await CreateCartUsecase(sl())(userId: userId);
}

Future<void> updateUserCart(Cart newCart)async{
 await UpdateCartUsecase(sl())(cart: newCart);
}

Future<List<Sales>> getCartSales()async{
  cartSales=[];
    print("sale before $cartSales");
        print("products before ${currentCart.productsId}");

  for (var element in currentCart.productsId) {
       final  res = await GetSingleSalesUsecase(sl())(element);
   res.fold((l) => null, (r) {
  
     cartSales.add(r);
   }); 
       print("sale after $cartSales");

  }

  return cartSales;
}


 List<String> get getCartSalesId=> cartSales.map((e) => e.id!).toList();
  List<String> get getCartmodelId=> cartSales.map((e) => e.modelId).toList();

 
 Future addSale(Sales newSale)async{
  if(!getCartmodelId.contains(newSale.modelId)){
    final addsale = await AddSaleUsecase(sl()).call(newSale);
    addsale.fold((l) => null, (r) async{
      cartSales.add(r);
      print(cartSales);
      await _updateSailes();
    });
  }else{
     Fluttertoast.showToast(
            msg: 'product already in cart!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            fontSize: 16.0);
  }
  await getUserCart(newSale.userId);
 }

void getReclamationPrice(){
  double sum=0.0;
  for (var sale in cartSales) {
   sum+=sale.totalPrice;
  }
  totalPrice= sum+shipping_fee;
}

Future _updateSailes()async{
          currentCart.productsId=getCartSalesId;
  print('update cart ${currentCart.productsId}');
  final rs = await UpdateCartUsecase(sl()).call(cart: currentCart);
    rs.fold((l) => null, (r)  async {
    });
    update();
}

Future deleteSale(String saleId)async{
  await DeleteSaleUsecase(sl()).call(saleId); 
  cartSales.removeWhere((element) => element.id==saleId);
  currentCart.productsId=getCartSalesId;
  await _updateSailes();
  await getUserCart(currentCart.userId);
  update();
}

Future clearCart()async{
 cartSales=[];
 await _updateSailes();
}

}