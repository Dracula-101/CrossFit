import 'dart:convert';

import 'package:crossfit/models/scanner_models/bar_code_model.dart';
import 'package:http/http.dart' as http;

class BarCodeAPI {
  static const String BASE_URL = "https://api.barcodelookup.com";
  static const List<String> API_KEY = [
    "hfwgtyjha3vswd7gc77j64phhp3vsg",
    "dtkw8m5szufoyy57ep7rx1uhxot2rr",
    "93blda41yczb7xofy9rm6rigu5kbmk",
  ];
  static const String findProducts = "/v3/products";

  static Future<dynamic> getProduct(String barCode) async {
    final response = await http.get(
      Uri.parse(
          '$BASE_URL$findProducts?barcode=$barCode&formatted=y&key=${API_KEY.first}'),
    );
    print(barCode);
    Map<String, dynamic> json;
    try {
      json = jsonDecode(response.body);
    } catch (e) {
      return null;
    }

    if (response.statusCode == 200) {
      return BarCodeModel.fromJson(json);
    } else {
      return null;
    }
  }
}
