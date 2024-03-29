import 'package:get_it/get_it.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:v_commerce/data/data_sources/remote_data_source/wishlist_remote_data_source.dart';
import 'package:v_commerce/data/repositories/cart_repository_impl.dart';
import 'package:v_commerce/data/repositories/wishlist_repository_impl.dart';
import 'package:v_commerce/domain/repositories/cart_repository.dart';
import 'package:v_commerce/domain/repositories/wishlist_repository.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/forget_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/reset_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/verify_otp_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/delete_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/get_cart_usecase.dart';
import 'package:v_commerce/domain/usecases/cart_usecases/update_cart_usecase.dart';

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

  /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl());
  sl.registerLazySingleton<WishListRemoteDataSource>(
      () => WishListRemoteDataSourceImpl());
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



}