import 'package:dio/dio.dart';
import 'package:example/CartScreen/cart_bloc.dart';
import 'package:example/CategoryScreen/CategoryDataSource.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/LoginScreen/AppInterceptors.dart';
import 'package:example/LoginScreen/bloc/auth_bloc.dart';
import 'package:example/LoginScreen/datasource.dart';
import 'package:example/ProductsScreen/ProductsDataSource.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerFactory<Dio>(() => Dio(
        BaseOptions(
          baseUrl: API_URL,
        ),
      )..interceptors.add(AppInterceptors()));

  getIt.registerFactory<LoginDataSource>(
      () => LoginDataSource(getIt(), getIt()));
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt(), getIt()));
  getIt.registerLazySingleton<Box>(() => Hive.box('tokens'));

  getIt.registerFactory<CategoryDataSource>(() => CategoryDataSource(getIt()));
  getIt.registerFactory<CategoryBloc>(() => CategoryBloc(getIt(), getIt(), getIt()));
  //
  getIt.registerFactory<ProductsDataSource>(() => ProductsDataSource(getIt()));

  getIt.registerFactory<CartBloc>(() => CartBloc());
}

const String API_URL = 'https://api.doover.tech/api/';
