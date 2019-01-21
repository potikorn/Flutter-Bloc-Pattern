import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:simple_bloc/login/login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _logicBloc;

  @override
  void initState() {
    _logicBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: LoginForm(
        loginBloc: _logicBloc,
      ),
    );
  }

  @override
  void dispose() {
    _logicBloc.dispose();
    super.dispose();
  }
}
