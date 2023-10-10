// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/screens/add_story.dart';
import 'package:story_app/screens/detail_story.dart';
import 'package:story_app/screens/list_story.dart';
import 'package:story_app/screens/login.dart';
import 'package:story_app/screens/register.dart';

import 'core/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? statusLogin = prefs.getBool("isLogin");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiProvider(apiClient: ApiClient()))
    ],
    child: MyApp(isLogin: statusLogin),
  ));
}

class MyApp extends StatelessWidget {
  final bool? isLogin;
  MyApp({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "StoryApp",
      routerConfig: _router, // Pass context to _router
    );
  }

  final GoRouter _router = GoRouter(
    // redirect: (context, state) {
    //   if (isLogin == null || false) {
    //     return "/";
    //   } else {
    //     return "/list";
    //   }
    // },
    routes: [
      GoRoute(
          path: "/", name: 'login', builder: (context, state) => const Login()),
      GoRoute(
          path: "/register",
          name: 'register',
          builder: (context, state) => const Register()),
      GoRoute(
          path: "/list",
          name: 'list',
          builder: (context, state) => const ListStory()),
      GoRoute(
          path: "/add",
          name: 'add',
          builder: (context, state) => const AddStory()),
      GoRoute(
          path: "/detail/:storyId",
          name: 'detail',
          builder: (context, state) => DetailStory(
                storyId: state.pathParameters['storyId']!,
              )),
    ],
  );
}
