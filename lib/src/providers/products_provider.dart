import 'dart:convert';
import 'dart:io';

import 'package:forms_validation/src/keys/keys.dart' as keys;
import 'package:http/http.dart' as http;
import 'package:forms_validation/src/models/product_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductsProvider{
  final _url = keys.URL_REST_API;
  
  Future<bool> createProdutc( Product product) async{
    final url = '$_url/products.json';
    final response = await http.post(url, body: product.toJsonString());
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<bool> editProdutc( Product product) async{
    final url = '$_url/products/${product.id}.json';
    final response = await http.put(url, body: product.toJsonString());
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

  Future<String> uploadImage(File imageFile) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/geovannybuitrago/image/upload?upload_preset=js3ydjvt');
    final mimeType = mime(imageFile.path).split('/'); // image/png
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );
    final file = await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    if( response.statusCode != 200 &&  response.statusCode != 201){
      print('Something went wrong ');
      print(response.body);
      return null;
    }
    final responseData = json.decode(response.body);
    return responseData['secure_url'];
  }
  
}