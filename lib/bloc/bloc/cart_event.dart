import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final int productId;

  AddToCart(this.productId);

  @override
  List<Object?> get props => [productId];
}
