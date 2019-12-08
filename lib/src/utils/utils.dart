import 'package:flutter/material.dart';

bool isNumber(String value){
  if(value.isEmpty) return false;

  final n = num.tryParse(value);
  return n == null ? false : true;
}

showAlertError(BuildContext context, String message){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Incorrect Info'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  ); 
}