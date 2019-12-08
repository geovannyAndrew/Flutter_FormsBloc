import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/models/product_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsBloc = Provider.productsBloc(context);
    productsBloc.loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: _buildList(productsBloc),
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

  Widget _buildList(ProductsBloc productsBloc) {

    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
        if(snapshot.hasData){
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index){
              final product = products[index];
              return _buildItemProduct(context,productsBloc, product);
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

  Widget _buildItemProduct(BuildContext context, ProductsBloc productsBloc, Product product){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.grey[200],
      ),
      onDismissed: (direction){
        productsBloc.deleteProduct(product.id);
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