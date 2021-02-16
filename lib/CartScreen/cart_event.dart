part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddProduct extends CartEvent {
  final Product product;

  AddProduct(this.product);
}

class RemoveProduct extends CartEvent {
  final Product product;

  RemoveProduct(this.product);
}

class InitCart extends CartEvent {

}

class ClearCart extends CartEvent {
}

class ConfirmCart extends CartEvent{}