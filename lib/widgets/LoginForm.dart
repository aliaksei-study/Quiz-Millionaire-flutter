import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/service/Service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Форма входа')),
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Введите почту';
                        }
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        return (!regex.hasMatch(value))
                            ? 'Неправильный адрес почты'
                            : null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Почта',
                          hintText: 'Введите почту...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (String value) {
                            if (value.length < 6) {
                              return 'Число символов должно быть больше 6';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Пароль',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          onPressed: () async{
                            if (_formKey.currentState.validate()) {
                              final String email = emailController.text;
                              final String password = passwordController.text;

                              final int statusCode = await login(email, password);
                              print(statusCode);
                              if(statusCode == 200) {
                                await getQuestions();
                                Navigator.pushNamed(
                                  context,
                                  '/admin-tabs',
                                );
                              }
                            }
                          },
                          child: Text('Войти')),
                    ),
                  ],
                )))));
  }
}
