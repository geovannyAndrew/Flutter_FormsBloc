import 'dart:convert';

import 'package:forms_validation/src/keys/keys.dart' as keys;
import 'package:http/http.dart' as http;


class UserProvider {

  final _firebaseToken = keys.FIREBASE_API_KEY;

  Future<Map<String, dynamic>> login( String email, String password) async{
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';
    final body = json.encode(authData);
    final response = await http.post(
      url,
      body: body
    );

    Map<String, dynamic> decodedResponse = json.decode(response.body);
    print(decodedResponse);

    if(decodedResponse.containsKey('idToken')){
      return {
        'ok'    :true,
        'token' : decodedResponse['idToken']
      };
    }
    else{
      return {
        'ok'    : false,
        'message' : decodedResponse['error']['message']
      };
    }
  }

  Future<Map<String, dynamic>> registerNewUser( String email , String password) async{
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';
    final body = json.encode(authData);
    final response = await http.post(
      url,
      body: body
    );

    Map<String, dynamic> decodedResponse = json.decode(response.body);
    print(decodedResponse);

    if(decodedResponse.containsKey('idToken')){
      return {
        'ok'    :true,
        'token' : decodedResponse['idToken']
      };
    }
    else{
      return {
        'ok'    : false,
        'message' : decodedResponse['error']['message']
      };
    }
  }
}