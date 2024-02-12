import 'dart:async';

import 'package:login_bloc/bloc/login_event.dart';
import 'package:login_bloc/bloc/login_state.dart';
import 'package:login_bloc/models/user_model.dart';
import 'package:login_bloc/repositories/login_repository.dart';

class LoginBloc {
  final _repository = LoginRepository();

  final StreamController<LoginEvent> _inputUserController =
      StreamController<LoginEvent>();
  final StreamController<LoginState> _outputUserController =
      StreamController<LoginState>();

  Sink<LoginEvent> get inputUser => _inputUserController.sink;
  Stream<LoginState> get outputUser => _outputUserController.stream;

  LoginBloc() {
    _inputUserController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LoginEvent event) async {
    List<User> users = [];

    _outputUserController.add(LoginLoadingState());

    if (event is GetLogin) {
      users = await _repository.getUsers();
    } else if (event is PostLogin) {
      users = await _repository.postUser(user: event.user);
    } else if (event is DeleteLogin) {
      users = await _repository.deleteUser(user: event.user);
    }

    _outputUserController.add(LoginLoadedState(user: users));
  }
}
