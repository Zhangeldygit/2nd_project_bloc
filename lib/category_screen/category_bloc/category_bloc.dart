import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/category_screen/CategoryDataSource.dart';
import 'package:example/category_screen/CategoryModel.dart';
import 'package:example/products_screen/Product_model.dart';
import 'package:example/products_screen/ProductsDataSource.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this._categoryDataSource, this.tokens, this.productsDataSource)
      : super(CategoryInitial());
  final ProductsDataSource productsDataSource;
  final CategoryDataSource _categoryDataSource;
  final Box tokens;

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield CategoryLoading();
      try {
        await tokens.get('access');
        await tokens.get('refresh');
        final List<Category> categories = await _categoryDataSource.getCategory();
        yield CategorySuccess(categories);
      } catch (e) {
        yield CategoryFailure(e.toString());
      }
    } else if (event is LoadProducts) {
      yield ProductsLoading();
      try {
        await tokens.get('access');
        await tokens.get('refresh');
        final List<Product> products = await productsDataSource.getProducts();
        yield ProductsSuccess(products);
      } catch (e) {
        yield ProductsFailure(e.toString());
      }
    } else if (event is SearchProductEvent) {
      yield CategoryLoading();
      try {
        final List<Product> products =
            await productsDataSource.getFilteredProducts(event.filter);
        yield FilteredProductState(products);
      } catch (e) {
        yield CategoryFailure(e.toString());
      }
    }
  }
}
