import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/di.dart';
import 'package:v_commerce/domain/entities/product3d.dart';
import 'package:v_commerce/domain/entities/wishlist.dart';
import 'package:v_commerce/domain/usecases/product_3d_usecases/get_3d_product_by_id_usecase.dart';
import 'package:v_commerce/domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'package:v_commerce/domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'package:v_commerce/domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';

class WishListController extends GetxController{
late  WishList currentWishlist;
List<Product3D> wishlistModel=[];

Future<WishList> getUserWishlist(String userId)async{

 final res= await GetWishListUsecase(sl())(userId: userId);
 res.fold((l) => null, (r) =>currentWishlist=r );
 await getWishlistTextures();
 return currentWishlist;
}

Future<void> addUserWishlist(String userId)async{
 await CreateWishListUsecase(sl())(userId: userId);
}

Future<void> updateUserWishlist(WishList newWishList)async{
 await UpdateWishListUsecase(sl())(wishlist: newWishList);
}

Future<List<Product3D>> getWishlistTextures()async{
  for (var element in currentWishlist.productsId) {
   final  res = await Get3DProductsByIdUseCase(sl())(element);
   res.fold((l) => null, (r) => wishlistModel.add(r)); 
  }
  return wishlistModel;
}

bool likedProduct(String textureId){
 return getWishlistIds.contains(textureId);
}

 List<String> get getWishlistIds=> wishlistModel.map((e) => e.id).toList();

Future toggleLikedTexture(Product3D texture)async{
  if(wishlistModel.contains(texture)){
    wishlistModel.remove(texture);
  }else{
    wishlistModel.add(texture);
  }
  currentWishlist.productsId=getWishlistIds;
 await updateUserWishlist(currentWishlist); 
update([ControllerID.LIKE_PRODUCT]);
}
}