import 'dart:async';

import 'package:forms_validation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{


  final _emailStreamController     = BehaviorSubject<String>();
  final _passwordStreamController  = BehaviorSubject<String>();

  //Insert values to stream
  Function(String) get changeEmail => _emailStreamController.sink.add;
  Function(String) get changePassword => _passwordStreamController.sink.add;

  //Recover data from string
  Stream<String> get emailStream => _emailStreamController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStreamController.stream.transform(validatePassword);

  Stream<bool> get formValidStream =>
    Observable.combineLatest2(emailStream, passwordStream, (es, ps){
      return true;
    });
  
  String get email    => _emailStreamController.value;
  String get password => _passwordStreamController.value;

  dispose(){
    _emailStreamController?.close();
    _passwordStreamController?.close();
  }

}