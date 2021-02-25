part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  final List<Category> categories = const [];
}

class CategoryLoading extends CategoryState{}

class CategorySuccess extends CategoryState {
  final List<Category> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends CategoryState {
  final String errorMessage;

  CategoryFailure(this.errorMessage);

  @override
  String toString() => errorMessage;
}




class ProductsInitial extends CategoryState {
  final List<Product> products = const [];
}

class ProductsLoading extends CategoryState{}

class ProductsSuccess extends CategoryState {
  final List<Product> products;

  ProductsSuccess(this.products);
}

class ProductsFailure extends CategoryState {
  final String error;

  ProductsFailure(this.error);

  @override
  String toString() => error;
}

class FilteredProductState extends CategoryState {
  final List<Product> products;

  FilteredProductState(this.products);

}