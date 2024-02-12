import 'package:login_bloc/models/user_model.dart';

abstract class LoginState {
  final List<User> user;

  LoginState({required this.user});
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super(user: []);
}

class LoginLoadingState extends LoginState {
  LoginLoadingState() : super(user: []);
}

class LoginLoadedState extends LoginState {
  LoginLoadedState({required List<User> user}) : super(user: user);
}
