part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class LoadProducts extends ProductEvent {}

class SaveProduct extends ProductEvent {
  final Product product;

  SaveProduct(this.product);
}

class UpdateProduct extends ProductEvent {
  final Product product;

  UpdateProduct(this.product);
}