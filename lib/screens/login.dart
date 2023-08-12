import 'package:flutter/material.dart';
import 'package:story_app/screens/register.dart';
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Future loginSuccess() async {
  //   if (_formKey.currentState!.validate()) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString(keyUserId, data!.userId!);
  //     prefs.setString(keyName, data.name!);
  //     prefs.setString(keyToken, data.token!);
  //     prefs.setBool(keyIsLogin, true);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const ListStory()),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false);
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
                  const Text('Login'),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
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
                  Consumer<ApiProvider>(
                    builder: (context, data, child) {
                      if (data.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (data.loginResult.error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(data.loginResult.message),
                          backgroundColor: Colors.red.shade300,
                          duration: const Duration(seconds: 3),
                        ));
                      } else {
                        return Text('login success');
                      }

                      return MaterialButton(
                        height: 46.0,
                        minWidth: double.infinity,
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          data.login(
                              emailController.text, passwordController.text);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
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
