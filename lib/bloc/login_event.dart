import 'package:login_bloc/models/user_model.dart';

abstract class LoginEvent {}

class GetLogin extends LoginEvent {}

class PostLogin extends LoginEvent {
  User user;
  PostLogin({required this.user});
}

class DeleteLogin extends LoginEvent {
  User user;
  DeleteLogin({required this.user});
}

class ValidateLogin extends LoginEvent {
  User user;
  ValidateLogin({required this.user});
}
