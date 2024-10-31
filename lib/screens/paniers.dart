import 'package:ecmmerce/bloc/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecmmerce/bloc/bloc/cart_bloc.dart';
import 'package:ecmmerce/bloc/bloc/cart_state.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> _refreshCart() async {
    context.read<CartBloc>().add(
        LoadCart()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return RefreshIndicator(
              onRefresh:
                  _refreshCart, 
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  final date =
                      DateTime.tryParse(item['date']) ?? DateTime.now();
                  final formattedDate = DateFormat('dd MMMM yyyy').format(date);

                  return ListTile(
                    title: Text(item['productId'].toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity: ${item['quantity']}'),
                        Text(
                            'Date: $formattedDate'), // Affiche la date formatée
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Aucun article dans le panier.'));
          }
        },
      ),
    );
  }
}
