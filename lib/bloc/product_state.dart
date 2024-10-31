

import 'package:ecmmerce/models/products.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  final ProductStatus status;
  final List<Product> products;
  final String error;

  ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.error = '',
  });

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }
}


