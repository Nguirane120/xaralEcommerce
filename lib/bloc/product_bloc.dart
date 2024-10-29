import 'package:bloc/bloc.dart';
import 'package:ecmmerce/apiservice.dart';
import 'package:ecmmerce/bloc/product_state.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductState()) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await apiService.fetchProducts();
      emit(state.copyWith(status: ProductStatus.success, products: products));
    } catch (error) {
      debugPrint(error.toString());
      emit(state.copyWith(
          status: ProductStatus.failure, error: error.toString()));
    }
  }
}
