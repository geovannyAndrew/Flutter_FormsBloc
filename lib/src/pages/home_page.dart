import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/models/product_model.dart';
import 'package:forms_validation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {

  final productsProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: _buildList(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      onPressed: ()=> Navigator.pushNamed(context, 'product'),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildList() {
    return FutureBuilder(
      future: productsProvider.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if(snapshot.hasData){
          return Container();
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}