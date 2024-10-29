import 'package:ecmmerce/bloc/product_bloc.dart';
import 'package:ecmmerce/bloc/product_state.dart';
import 'package:ecmmerce/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productlist extends StatefulWidget {
  Productlist({super.key});

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProductStatus.success) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(product: product),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load products'));
          }
        },
      ),
    );
  }
}
