import 'dart:core';

import 'package:flutter/material.dart';
import 'package:forms_validation/src/bloc/provider.dart';
import 'package:forms_validation/src/providers/user_provider.dart';
import 'package:forms_validation/src/utils/utils.dart';

class LoginPage extends StatelessWidget {
  final userProvider = UserProvider();  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(context),
          _buildLoginForm(context)
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var height = size.height*0.40;
    final isLanscape = MediaQuery.of(context).orientation == Orientation.landscape;
    if(isLanscape){
      height = size.height*0.6;
    }
    final colorBackground = Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        )
      ),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );

    return Stack(
      children: <Widget>[
        colorBackground,
        Positioned(
          top: 80,
          left: 30,
          child: circle
        ),
        Positioned(
          top: -40,
          right: -30,
          child: circle
        ),
        Positioned(
          bottom: -50,
          right: -10,
          child: circle
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(top: 60.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text('Geovanny Buitrago',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width*0.85;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0,5),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(height: 20.0), 
                _buildEmail(context, bloc),
                SizedBox(height: 20.0),
                _buildPassword(context, bloc),
                SizedBox(height: 20.0),
                _buildSendButton(context, bloc)
              ],
            ),
          ),

          FlatButton(
            child: Text('Create an account'),
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'register'),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _buildEmail(BuildContext context, LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'example@email.com',
              labelText: 'Email',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _buildPassword(BuildContext context, LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,
                color: Colors.deepPurple,
              ),
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
    
  }

  Widget _buildSendButton(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Login'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _login(context, bloc) : null,
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) async {
    Map info = await userProvider.login(bloc.email, bloc.password);
    if(info['ok']){
      Navigator.pushReplacementNamed(context,'home');
    }
    else{
      showAlertError(context, info['message']);
    }
  }
}