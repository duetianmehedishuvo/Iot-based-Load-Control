import 'package:flutter/material.dart';
import 'package:women_safety/util/helper.dart';

void showMessage({String? message, bool isError = true}) {
  ScaffoldMessenger.of(Helper.navigatorKey.currentState!.context).showSnackBar(
    SnackBar(content: Text(message!, style: const TextStyle(color: Colors.white)), backgroundColor: isError ? Colors.red : Colors.green),
  );
}
