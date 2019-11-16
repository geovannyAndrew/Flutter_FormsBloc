import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: <Widget>[
                _buildNameField(context),
                _buildPriceField(context),
                SizedBox(
                  height: 16,
                ),
                _buildButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product'
      ),
    );
  }

  Widget _buildPriceField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price'
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Save'),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      onPressed: (){},
    );
  }
}