class User {
  String email = "";
  String password = "";

  User({required this.email, required this.password});

  static bool login(
      List<User> users, String controlEmail, String controlPassword) {
    return users.any((User user) =>
        user.email == controlEmail && user.password == controlPassword);
  }
}
