import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/authentication/authentication.dart';
import 'package:simple_bloc/login/login.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

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
        if (loginstate is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${loginstate.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
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
                onPressed:
                    loginstate is !LoginLoading ? _onLoginButtonPressed : null,
                child: Text('Login'),
              ),
              Container(
                child: loginstate is LoginLoading
                    ? CircularProgressIndicator()
                    : null,
              )
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    ));
  }
}
