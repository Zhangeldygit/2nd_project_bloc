import 'package:dio/dio.dart';
import 'package:example/ProductsScreen/Product_model.dart';

class ProductsDataSource {
  final Dio dio;

  ProductsDataSource(this.dio);

  Future<List<Product>> getProducts() async {
    Response response = await dio.get('products/');
    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> getFilteredProducts(String filter) async{
    Response response = await dio.get('products/?name=$filter');

    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }
}

