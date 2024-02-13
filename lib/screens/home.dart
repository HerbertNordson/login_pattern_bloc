import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc/bloc/login_bloc.dart';
import 'package:login_bloc/bloc/login_event.dart';
import 'package:login_bloc/bloc/login_state.dart';
import 'package:login_bloc/models/user_model.dart';
import 'package:login_bloc/screens/logged.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LoginBloc _loginBloc;
  final _formField = GlobalKey<FormState>();
  final TextEditingController _controlEmail = TextEditingController();
  final TextEditingController _controlPassword = TextEditingController();

  void handleLogin(List<User> users) {
    User.login(users, _controlEmail.text, _controlPassword.text)
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Logged(),
            ),
          )
        : handleDialog();
  }

  void handleDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: const Text("Usuário não encontrado"),
            content: const Text("Usuário ou senha está incorreto!"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.inputUser.add(GetLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "Bem-vindo ao APP",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formField,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _controlEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(label: Text("E-mail")),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Por favor insira o endereço de e-mail";
                              } else if (!EmailValidator.validate(
                                  value, true)) {
                                return "Insira um e-mail válido";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _controlPassword,
                            obscureText: true,
                            decoration:
                                const InputDecoration(label: Text("Password")),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Por favor insira a senha";
                              } else if (value.length < 6) {
                                return "Insira uma senha com 6 carqcteres ou mais";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
                            left: 16.0,
                            right: 16.0,
                            bottom: 16.0,
                          ),
                          child: StreamBuilder<LoginState>(
                              stream: _loginBloc.outputUser,
                              builder: (context, state) {
                                if (state is LoginLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.data is LoginLoadedState) {
                                  final users = state.data?.user ?? [];

                                  return ElevatedButton(
                                    onPressed: () {
                                      if (_formField.currentState!.validate()) {
                                        handleLogin(users);
                                      }
                                    },
                                    style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(400, 50)),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.deepPurpleAccent),
                                    ),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  );
                                } else {
                                  return ElevatedButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(400, 50)),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.deepPurpleAccent),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
