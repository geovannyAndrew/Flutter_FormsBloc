import 'dart:io';

import 'package:forms_validation/src/models/product_model.dart';
import 'package:forms_validation/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc{

  final _productsController = BehaviorSubject<List<Product>>();
  final _loadingController = BehaviorSubject<bool>();

  final _productsProvider = ProductsProvider();

  Stream<List<Product>> get productsStream => _productsController.stream;
  Stream<bool> get loading => _loadingController.stream;

  loadProducts() async{
    final products = await _productsProvider.getProducts();
    _productsController.sink.add(products);
  }

  Future<bool> addNewProduct(Product product) async{
    _loadingController.sink.add(true);
    final response = await _productsProvider.createProdutc(product);
    _loadingController.sink.add(false);
    return response;
  }

  Future<bool> editProduct(Product product) async{
    _loadingController.sink.add(true);
    final response = await _productsProvider.editProdutc(product);
    _loadingController.sink.add(false);
    return response;
  }

  Future<String> uploadPhoto(File photo) async{
    _loadingController.sink.add(true);
    final response = await _productsProvider.uploadImage(photo);
    _loadingController.sink.add(false);
    return response;
  }

  Future<int> deleteProduct(String id) async{
    _loadingController.sink.add(true);
    final response = await _productsProvider.deleteProduct(id);
    _loadingController.sink.add(false);
    return response;
  }


  dispose(){
    _productsController?.close();
    _loadingController?.close();
  }
}