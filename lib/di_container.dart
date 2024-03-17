import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/data/datasource/remote/dio/dio_client.dart';
import 'package:women_safety/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:women_safety/data/repository/splash_repo.dart';
import 'package:women_safety/provider/auth_provider.dart';
import 'package:women_safety/util/app_constant.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstant.baseUrl, sl(), sharedPreferences: sl(), loggingInterceptor: sl()));
  // Repository
  sl.registerLazySingleton(() => SplashRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => AuthProvider());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
