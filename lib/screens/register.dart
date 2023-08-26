import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:story_app/models/register.dart';

import '../core/api_client.dart';
import '../utils/validator.dart';
import 'login.dart';

class Register extends StatefulWidget {
  static String routeName = "/register";
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      try {
        RegisterResult res = await _apiClient.register(
          nameController.text,
          emailController.text,
          passwordController.text,
        );
        if (context.mounted) {
          showAlertDialog(context, res.message);
        }
      } on DioException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.response!.data.toString()),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
  }

  showAlertDialog(BuildContext context, String message) {
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () async {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Informasi"),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text('Register'),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      return Validator.validateText(value ?? "", 'Nama');
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Nama",
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
                      return Validator.validateText(value ?? "", 'Email');
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
                  MaterialButton(
                    height: 46.0,
                    minWidth: double.infinity,
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: register,
                    child: const Text(
                      "Register",
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
                      const Text('Sudah punya akun ? '),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text(
                            'Login disini ',
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
