import 'package:ecmmerce/main.dart';
import 'package:ecmmerce/widgets/productList.dart';
import 'package:ecmmerce/widgets/scrollcard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(left: 20, top: 15),
              alignment: Alignment.centerLeft,
              child: const Text("LIST DES CATEGORIES")),
          const ScrollCard(),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.only(left: 20, top: 15),
              alignment: Alignment.centerLeft,
              child: const Text("LIST DES PRODUITS")),
          Expanded(child: Productlist())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/productForm');
        },
        child: const Icon(
          Icons.production_quantity_limits_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
