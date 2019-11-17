import 'dart:convert';

import 'package:forms_validation/src/keys/keys.dart' as keys;
import 'package:http/http.dart' as http;
import 'package:forms_validation/src/models/product_model.dart';

class ProductsProvider{
  final _url = keys.URL_REST_API;
  
  Future<bool> createProdutc( Product product) async{
    final url = '$_url/products.json';
    final response = await http.post(url, body: product.toJsonString());
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }
  
}