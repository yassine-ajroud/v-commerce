import 'package:get_it/get_it.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/forget_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/reset_password_usecase.dart';
import 'package:v_commerce/domain/usecases/authentication_usecases/verify_otp_usecase.dart';

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

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
   sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authRemoteDataSource: sl(), authLocalDataSource: sl()));

  /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
      
  /* usecases */
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

}