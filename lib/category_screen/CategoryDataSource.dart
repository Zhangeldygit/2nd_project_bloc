import 'package:dio/dio.dart';
import 'package:example/category_screen/CategoryModel.dart';

class CategoryDataSource {
  final Dio dio;

  CategoryDataSource(this.dio);

  Future<List<Category>> getCategory() async {
    Response response = await dio.get('products/categories/');
    return (response.data as List).map((e) => Category.fromJson(e)).toList();
  }
}
