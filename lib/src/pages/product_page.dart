import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forms_validation/src/models/product_model.dart';
import 'package:forms_validation/src/utils/decimal_text_input_formatter.dart';
import 'package:forms_validation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  var product = Product();

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
      onPressed: _submit,
    );
  }

  _submit(){
    if(!formKey.currentState.validate()) return;
    print('Todo Ok');
    formKey.currentState.save();
    print(product.title);
    print(product.value);
  }

  Widget _buildAvailable(BuildContext context) {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value)=> setState(()=> product.available = value),
    );
  }
}