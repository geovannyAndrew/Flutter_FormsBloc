import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forms_validation/src/models/product_model.dart';
import 'package:forms_validation/src/providers/products_provider.dart';
import 'package:forms_validation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {  

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var product = Product();
  bool _saving = false;
  final productProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {

    final Product productData = ModalRoute.of(context).settings.arguments;
    if(productData != null){
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
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
            key: formKey,
            child: Column(
              children: <Widget>[
                _buildNameField(context),
                _buildPriceField(context),
                _buildAvailable(context),
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
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      onSaved: (value) => product.title = value,
      validator: (value){
        if(value.length < 3){
          return 'Enter the product name';
        }
        return null;
      },
    );
  }

  Widget _buildPriceField(BuildContext context) {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [  WhitelistingTextInputFormatter.digitsOnly ],
      decoration: InputDecoration(
        labelText: 'Price'
      ), 
      onSaved: (value) => product.value = double.parse(value),
      validator: (value){
        if(utils.isNumber(value)){
          return null;
        }
        else{
          return 'Only numbers';
        }
      },
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
      onPressed: _saving ? null : _submit,
    );
  }

  _submit(){
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _saving = true;
    });

    if(product.id == null){
      productProvider.createProdutc(product);
    }
    else{
      productProvider.editProdutc(product);
    }
    setState(() {
      _saving = false;
    });
    _showSnackBar('Product Saved!');
    Navigator.pop(context);
  }

  Widget _buildAvailable(BuildContext context) {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value)=> setState(()=> product.available = value),
    );
  }

  _showSnackBar(String message){
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(
        milliseconds: 1500
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}