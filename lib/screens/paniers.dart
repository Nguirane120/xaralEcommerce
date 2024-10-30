import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecmmerce/bloc/bloc/cart_bloc.dart';
import 'package:ecmmerce/bloc/bloc/cart_event.dart';
import 'package:ecmmerce/bloc/bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item['productId'].toString()),
                  subtitle: Text('Quantity: ${item['quantity']}'),
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No items in cart'));
          }
        },
      ),
    );
  }
}
