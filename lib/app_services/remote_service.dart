import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../app_models/products_model.dart';

import 'package:http/http.dart' as http;

Future<Products?> getData() async {
  Products? product;
  try {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      product = Products.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return product;
}