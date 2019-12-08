import 'package:flutter/material.dart';
import 'package:forms_validation/src/models/product_model.dart';
import 'package:forms_validation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {

  final productsProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {

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
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index){
              final product = products[index];
              return _buildItemProduct(context, product);
            },
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildItemProduct(BuildContext context, Product product){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.grey[200],
      ),
      onDismissed: (direction){
        productsProvider.deleteProduct(product.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (product.fotoUrl == null) ?
            Image(
              image: AssetImage('assets/no-image.png'),
            ) : FadeInImage(
              image: NetworkImage(product.fotoUrl),
              placeholder: AssetImage('assets/jar-loading.gif'),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text('${product.title} - ${product.value}'),
              subtitle: Text(product.id),
              onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
            )
          ],
        ),
      ),
    );
  }
}