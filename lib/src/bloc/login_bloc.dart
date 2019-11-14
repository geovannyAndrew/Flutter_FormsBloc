import 'dart:async';

class LoginBloc{


  final _emailStreamController     = StreamController<String>.broadcast();
  final _passwordStreamController  = StreamController<String>.broadcast();

  //Insert values to stream
  Function(String) get changeEmail => _emailStreamController.sink.add;
  Function(String) get changePassword => _passwordStreamController.sink.add;

  //Recover data from string
  Stream<String> get emailStream => _emailStreamController.stream;
  Stream<String> get passwordStream => _passwordStreamController.stream;

  dispose(){
    _emailStreamController?.close();
    _passwordStreamController?.close();
  }

}