import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:women_safety/animation/slideleft_toright.dart';
import 'package:women_safety/animation/slideright_toleft.dart';
import 'package:women_safety/util/theme/app_colors.dart';

showLog(message) {
  log("APP SAYS: $message");
}

double screenHeight() {
  return MediaQuery.of(Helper.navigatorKey.currentState!.context).size.height;
}

double screenWeight() {
  return MediaQuery.of(Helper.navigatorKey.currentState!.context).size.width;
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

class Helper {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static toScreen(screen) {
    Navigator.push(navigatorKey.currentState!.context, SlideRightToLeft(page: screen));
  }

  static back() {
    Navigator.of(navigatorKey.currentState!.context).pop();
  }

  static toReplacementScreenSlideRightToLeft(screen) {
    Navigator.pushReplacement(navigatorKey.currentState!.context, SlideRightToLeft(page: screen));
  }

  static toReplacementScreenSlideLeftToRight(screen) {
    Navigator.pushReplacement(navigatorKey.currentState!.context, SlideLeftToRight(page: screen));
  }

  static toRemoveUntilScreen(screen) {
    Navigator.pushAndRemoveUntil(navigatorKey.currentState!.context, SlideRightToLeft(page: screen), (route) => false);
  }

  static onWillPop(screen) {
    Navigator.pushAndRemoveUntil(navigatorKey.currentState!.context, SlideRightToLeft(page: screen), (route) => false);
  }

  static showSnack(context, message, {color = colorPrimary, duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)), backgroundColor: color, duration: Duration(seconds: duration)));
  }

  static circularProgress(context) {
    const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(colorPrimary)));
  }

  static boxDecoration(Color color, double radius) {
    BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
