import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/products_screen/Product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, List<Product>> {
  Box box = Hive.box('Cart');

  CartBloc() : super(<Product>[]);

  @override
  Stream<List<Product>> mapEventToState(CartEvent event) async* {
    //Add item event
    if (event is AddProduct) {


      yield box.values.cast<Product>().toList();
    } if (event is RemoveProduct) {

      yield box.values.cast<Product>().toList();

    } else {

      yield box.values.cast<Product>().toList();

    } if(event is ClearCart) {

      box.clear();
      yield box.values.cast<Product>().toList();

    } else {

      yield box.values.cast<Product>().toList();

    } if(event is ConfirmCart) {

      box.clear();
      yield box.values.cast<Product>().toList();

    } else {

      yield box.values.cast<Product>().toList();

    }
  }
}