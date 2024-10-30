import 'package:ecmmerce/models/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Productdetail extends StatefulWidget {
  final Product product;

  const Productdetail({Key? key, required this.product}) : super(key: key);

  @override
  State<Productdetail> createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                context.go('/home');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Text('Detail produit'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du produit
            Center(
              child: Image.network(
                widget.product.image as String,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Titre du produit
            Text(
              widget.product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Prix du produit
            Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            // Description du produit
            Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
