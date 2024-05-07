import 'package:get_it/get_it.dart';
import 'package:v_commerce/data/data_Sources/remote_data_source/promotion_remote_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/category_remote_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/supplier_remote_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/wishlist_remote_data_source.dart';
import 'package:v_commerce/data/repositories/cart_repository_impl.dart';
import 'package:v_commerce/data/repositories/category_reopsitory.dart';
import 'package:v_commerce/data/repositories/product_repository_impl.dart';
import 'package:v_commerce/data/repositories/promotion_repository_impl.dart';
import 'package:v_commerce/data/repositories/supplier_repository_impl.dart';
import 'package:v_commerce/data/repositories/wishlist_repository_impl.dart';
import 'package:v_commerce/domain/repositories/cart_repository.dart';
import 'package:v_commerce/domain/repositories/category_repository.dart';
import 'package:v_commerce/domain/repositories/product_repository.dart';
import 'package:v_commerce/domain/repositories/promotion_repository.dart';
import 'package:v_commerce/domain/repositories/supplier_repository.dart';
import 'package:v_commerce/domain/repositories/wishlist_repository.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/forget_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/reset_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/verify_otp_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/delete_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/get_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/category_usecases/get_categories_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'package:v_commerce/domain/usecases/product_usecases/get_products_by_category_usecase.dart';
import 'package:v_commerce/domain/usecases/promotion_usecases/get_all_promotions_usecase.dart';
import 'package:v_commerce/domain/usecases/sub_category_usecases/get_all_sub_categories_usecase.dart';
import 'package:v_commerce/domain/usecases/supplier_usecases/get_supplier_by_ud_usecase.dart';

import 'data/data_sources/local_data_sorce/authentication_local_data_source.dart';
import 'data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'data/repositories/authentication_repository_impl.dart';
import 'domain/repositories/authentication_repository.dart';
import 'domain/usecases/authentication_usecases/auto_login_usecase.dart';
import 'domain/usecases/authentication_usecases/create_account_usecase.dart';
import 'domain/usecases/authentication_usecases/facebook_login_usecase.dart';
import 'domain/usecases/authentication_usecases/get_user_usecase.dart';
import 'domain/usecases/authentication_usecases/google_login_usecase.dart';
import 'domain/usecases/authentication_usecases/login_usecase.dart';
import 'domain/usecases/authentication_usecases/logout_usecase.dart';
import 'domain/usecases/authentication_usecases/update_profil_usecase.dart';
import 'domain/usecases/product_usecases/get_sorted_products_usecase.dart';
import 'domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/delete_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
   sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authRemoteDataSource: sl(), authLocalDataSource: sl()));
  sl.registerLazySingleton<CartRepository>(() =>
      CartRepositoryImpl(sl()));
  sl.registerLazySingleton<WishListRepository>(() =>
      WishListRepositoryImpl(sl()));
  sl.registerLazySingleton<PromotionRepository>(() =>
      PromotionRepositoryImpl(sl()));   
  sl.registerLazySingleton<ProductRepository>(() =>
      ProductRepositoryImp(sl()));   
  sl.registerLazySingleton<CategoryRepository>(() =>
      CategoryRepositoryImpl(sl()));   
  sl.registerLazySingleton<SupplierRepository>(() =>
      SupplierRepositoryImpl(sl())); 

  /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl());
  sl.registerLazySingleton<WishListRemoteDataSource>(
      () => WishListRemoteDataSourceImpl());
  sl.registerLazySingleton<PromotionRemoteDataSource>(
      () => PromotionRemoteDataSourceImpl());    
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());   
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl());  
  sl.registerLazySingleton<SupplierRemoteDataSource>(
      () => SupplierRemoteDataSourceImpl());  
 
  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => OTPVerificationUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfilUsecase(sl()));
  sl.registerLazySingleton(() => GetUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUsecase(sl()));
  sl.registerLazySingleton(() => FacebookLoginUsecase(sl()));
  sl.registerLazySingleton(() => AutoLoginUsecase(sl()));

  //cart//
  sl.registerLazySingleton(() => CreateCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(sl()));
  sl.registerLazySingleton(() => GetCartUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCartUsecase(sl()));

  //wishlist//
  sl.registerLazySingleton(() => CreateWishListUsecase(sl()));
  sl.registerLazySingleton(() => UpdateWishListUsecase(sl()));
  sl.registerLazySingleton(() => GetWishListUsecase(sl()));
  sl.registerLazySingleton(() => DeleteWishListUsecase(sl()));

  //promotion//
  sl.registerLazySingleton(() => GetAllPromotionsUsecase(sl()));

  //products//
  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetSortedProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsByCategoryUsecase(sl()));

  //categories//
  sl.registerLazySingleton(() => GetAllCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSubCategoriesUsecase(sl()));

  //supplier//
  sl.registerLazySingleton(() => GetSupplierByIdUsecase(sl()));

}