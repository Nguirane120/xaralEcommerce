import 'package:bloc/bloc.dart';
import 'package:ecmmerce/apiservice.dart';
import 'package:ecmmerce/bloc/product_state.dart';
import 'package:ecmmerce/models/products.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductState()) {
    on<SaveProduct>(_onSaveProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<LoadProducts>(_onLoadProducts);
  }
  Future<void> _onSaveProduct(
      SaveProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      // Envoie le produit à l'API pour l'ajouter
      final newProduct = await apiService.addProduct(event.product);
      // Ajoute le nouveau produit à la liste des produits existants
      emit(state.copyWith(
        status: ProductStatus.success,
        products: List.from(state.products)..add(newProduct),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        error: 'Échec de l\'enregistrement du produit',
      ));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final updatedProduct = await apiService.updateProduct(event.product);
      final updatedProducts = state.products.map((product) {
        return product.id == updatedProduct.id ? updatedProduct : product;
      }).toList();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: updatedProducts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        error: 'Échec de la mise à jour du produit',
      ));
    }
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
