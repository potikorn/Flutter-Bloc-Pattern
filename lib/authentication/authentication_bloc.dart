import 'dart:math';

import 'package:bloc/bloc.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationUnintialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      // final bool hasToken = await
      final bool hasToken = await randomExpiredToken();
      if (hasToken)
        yield AuthenticationAuthenticated();
      else
        yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      // TODO repository
      await Future.delayed(Duration(seconds: 1));
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      // TODO repository
      await Future.delayed(Duration(seconds: 1));
      yield AuthenticationUnauthenticated();
    }
  }

  randomExpiredToken() {
    return Future.delayed(Duration(seconds: 1), () {
      var rand = Random().nextInt(1);
      if (rand == 0) {
        return false;
      } else {
        return true;
      }
    });
  }
}
