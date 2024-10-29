import 'package:ecmmerce/bloc/bloc/categories_bloc.dart';
import 'package:ecmmerce/bloc/bloc/categories_state.dart';
import 'package:ecmmerce/widgets/categoryContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollCard extends StatelessWidget {
  const ScrollCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<CategoriesBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoaded) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: state.categories.map((category) {
                      debugPrint(category);
                      return CategoryContainer(
                        cardColor: Color(0xff0C5E69), // Choisissez une couleur dynamique
                        cardText: category,
                      );
                    }).toList(),
                  );
                } else if (state is CategoryError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text("Aucune catégorie"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
