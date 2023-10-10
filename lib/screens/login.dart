import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/models/login.dart';
import 'package:story_app/screens/register.dart';
import 'package:story_app/utils/validator.dart';

import '../core/api_client.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    login() async {
      if (_formKey.currentState!.validate()) {
        try {
          LoginResult res = await _apiClient.login(
            emailController.text,
            passwordController.text,
          );
          if (res.error == false) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('name', res.loginResult.name);
            prefs.setString('token', res.loginResult.token);
            prefs.setString('userId', res.loginResult.userId);
            prefs.setBool('isLogin', true);
          }
          if (context.mounted) GoRouter.of(context).pushNamed("list");
        } on DioException catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.response!.data.toString()),
              backgroundColor: Colors.red.shade300,
            ));
          }
        }
      }
      setState(() {
        isSubmit = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login'),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      return Validator.validateEmail(value ?? "");
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      return Validator.validateText(value ?? "", 'Password');
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isSubmit
                      ? const CircularProgressIndicator()
                      : MaterialButton(
                          height: 46.0,
                          minWidth: double.infinity,
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              isSubmit = true;
                            });
                            login();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Belum punya akun ? '),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
                          },
                          child: const Text(
                            'Register disini ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ))
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
