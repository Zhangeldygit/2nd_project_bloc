import 'package:dio/dio.dart';
import 'package:example/CategoryScreen/Category_model.dart';

class CategoryDataSource {
  final Dio dio;

  CategoryDataSource(this.dio);

  Future<List<Category>> getCategory() async {
    Response response = await dio.get('products/categories/');
    return (response.data as List).map((e) => Category.fromJson(e)).toList();
  }
}
