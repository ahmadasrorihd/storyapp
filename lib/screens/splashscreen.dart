import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkSession();
    super.initState();
  }

  checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? statusLogin = prefs.getBool(keyIsLogin);
    if (statusLogin == null || false) {
      if (context.mounted) context.pushReplacementNamed('login');
    } else {
      if (context.mounted) context.pushReplacementNamed('list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
