import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String> loadMapStyle(BuildContext context) async {
  return await rootBundle.loadString('assets/dark_map_style.json');
}
