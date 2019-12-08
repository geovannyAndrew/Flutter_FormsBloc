import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/login_bloc.dart';
export 'package:forms_validation/src/bloc/login_bloc.dart';
import 'package:forms_validation/src/bloc/products_bloc.dart';
export 'package:forms_validation/src/bloc/products_bloc.dart';

class Provider extends InheritedWidget{

  final loginBloc     = LoginBloc();
  final _productsBloc = ProductsBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}){
    if(_instance == null){
      _instance = Provider._(key:key, child: child);
    }
    return _instance;
  }

  Provider._({Key key, Widget child})
    : super(key:key, child: child);

//  Provider({Key key, Widget child})
//    : super(key:key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    //Its almost always true 99% times
    return true;
  }

  static LoginBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }

  static ProductsBloc productsBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._productsBloc;
  }
}