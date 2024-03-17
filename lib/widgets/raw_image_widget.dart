import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:women_safety/util/helper.dart';

Widget getImageBase64(String thumbnail, {double height=200}) {
  String lastThumbnail = thumbnail.split(',').last;
  final byteImage = const Base64Decoder().convert(lastThumbnail.replaceAll('%2F', '/').replaceAll('%2B', '+'));

  Widget image = Image.memory(
    byteImage,
    gaplessPlayback: true,
    height: height,
    fit: BoxFit.fitWidth,
    width: MediaQuery.of(Helper.navigatorKey.currentState!.context).size.width,
  );
  return image;
}
