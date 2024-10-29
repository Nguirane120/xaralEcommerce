import 'package:ecmmerce/bloc/bloc/categories_bloc.dart';
import 'package:ecmmerce/bloc/bloc/categories_state.dart';
import 'package:ecmmerce/widgets/categoryContainer.dart';
import 'package:ecmmerce/widgets/productList.dart';
import 'package:ecmmerce/widgets/scrollcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.centerLeft,
            child: Text("LIST DES CATEGORIES")),
        ScrollCard(),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.centerLeft,
            child: Text("LIST DES PRODUITS")),
        Expanded(child: Productlist())
      ],
    ));
  }
}
