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

  Future<List<Product>> getProducts() async{
    final url = '$_url/products.json';
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    if(decodedData == null) return [];
    final products = List<Product>();
    decodedData.forEach((id, productMap){
      final productTemp = Product.fromJson(productMap);
      productTemp.id = id;
      products.add(productTemp);
    });
    return products;
  }

  Future<int> deleteProduct(String id) async{
    final url = '$_url/products/$id.json';
    final response = await http.delete(url);
    print(json.decode(response.body));
    return 1;
  }
  
}