import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc/authentication/authentication.dart';
import 'package:simple_bloc/login/login_event.dart';
import 'package:simple_bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  void onLoginButtonPressed({String username, String password}) {
    dispatch(
      LoginButtonPressed(
        username: username,
        password: password,
      ),
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        // get token from API.
        final token = await _authenticate(event.username, event.password);
        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
        // yield LoginState.success(token);
      } catch (error) {
        yield LoginFailure(error: error);
      }
    }
  }

  _authenticate(String username, String password) {
    return Future.delayed(Duration(seconds: 1), () {
      print("USERNAME $username: and PASSWORD: $password");
      if (username == 'admin1' && password == 'admin1')
        return "TOKEN STRING";
      else
        throw ("Error login");
    });
  }
}
