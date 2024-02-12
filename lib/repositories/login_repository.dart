import 'package:login_bloc/models/user_model.dart';

class LoginRepository {
  final List<User> _users = [];

  Future<List<User>> getUsers() async {
    _users.addAll(
      [
        User(email: "herbert_nordson@hotmail.com", password: "Ola@123"),
        User(email: "usuario_1@hotmail.com", password: "Ola@1234"),
        User(email: "usuario_2@hotmail.com", password: "Ola@1235"),
        User(email: "usuario_3@hotmail.com", password: "Ola@1236"),
        User(email: "usuario_4@hotmail.com", password: "Ola@1237"),
      ],
    );

    /* A utilização do delayed foi com o intuito de 
    simular um tempo de resposta de uma API */
    return Future.delayed(
      const Duration(seconds: 2),
      () => _users,
    );
  }

  Future<List<User>> postUser({required User user}) async {
    _users.add(user);

    /* A utilização do delayed foi com o intuito de 
    simular um tempo de resposta de uma API */
    return Future.delayed(
      const Duration(seconds: 2),
      () => _users,
    );
  }

  Future<List<User>> deleteUser({required User user}) async {
    _users.remove(user);

    /* A utilização do delayed foi com o intuito de 
    simular um tempo de resposta de uma API */
    return Future.delayed(
      const Duration(seconds: 2),
      () => _users,
    );
  }
}
