import 'package:bloc/bloc.dart';
import 'package:ecmmerce/apiservice.dart';
import 'package:ecmmerce/bloc/bloc/categories_event.dart';
import 'package:ecmmerce/bloc/bloc/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CategoriesBloc extends Bloc<CategoryEvent, CategoryState> {
  final ApiService categoryService;
  CategoriesBloc(this.categoryService) : super(CategoryInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  void _onFetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading()); // Émettre l'état de chargement
    try {
      final categories = await categoryService.fetchCategories();
      debugPrint(categories.toString());
      emit(
          CategoryLoaded(categories)); // Émet l'état chargé avec les catégories
    } catch (e) {
      emit(CategoryError(
          "Erreur lors de la récupération des catégories : $e")); // Émettre une erreur
    }
  }
}
