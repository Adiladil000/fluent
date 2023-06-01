import 'package:flutter/material.dart';

void errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: const StadiumBorder(),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.black87,
    content: Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
  ));
}
