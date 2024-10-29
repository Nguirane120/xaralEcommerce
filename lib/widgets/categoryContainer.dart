import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  CategoryContainer(
      {super.key, required this.cardColor, required this.cardText});
  final Color cardColor;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(10)),
      child: Text(
        cardText,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
