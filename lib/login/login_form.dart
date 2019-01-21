import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/login/login.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;

  LoginForm({Key key, @required this.loginBloc}) : super(key: key);

  @override
  LoginFormState createState() {
    return new LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (context, loginstate) {
        if (loginstate.token.isNotEmpty) {
          // do something
          debugPrint(loginstate.token);
        }
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: passwordController,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: loginstate.isLoginButtonEnabled
                    ? _onLoginButtonPressed
                    : null,
                child: Text('Login'),
              ),
              (loginstate.error.isNotEmpty)
                  ? Text(loginstate.error)
                  : Container(),
              Container(
                child:
                    loginstate.isLoading ? CircularProgressIndicator() : null,
              )
            ],
          ),
        );
      },
    );
  }

  _onLoginButtonPressed() {
    widget.loginBloc.onLoginButtonPressed(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
