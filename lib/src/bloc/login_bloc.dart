import 'dart:async';

import 'package:forms_validation/src/bloc/validators.dart';

class LoginBloc with Validators{


  final _emailStreamController     = StreamController<String>.broadcast();
  final _passwordStreamController  = StreamController<String>.broadcast();

  //Insert values to stream
  Function(String) get changeEmail => _emailStreamController.sink.add;
  Function(String) get changePassword => _passwordStreamController.sink.add;

  //Recover data from string
  Stream<String> get emailStream => _emailStreamController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStreamController.stream.transform(validatePassword);

  dispose(){
    _emailStreamController?.close();
    _passwordStreamController?.close();
  }

}