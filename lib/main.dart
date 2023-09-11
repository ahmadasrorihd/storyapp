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
import 'package:story_app/utils/constant.dart';

import 'core/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? statusLogin = prefs.getBool(keyIsLogin);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiProvider(apiClient: ApiClient()))
    ],
    child: MyApp(isLogin: statusLogin),
  ));
}

class MyApp extends StatefulWidget {
  final bool? isLogin;
  const MyApp({
    Key? key,
    this.isLogin,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const Register();
      },
    ),
    GoRoute(
      path: '/list',
      builder: (BuildContext context, GoRouterState state) {
        return const ListStory();
      },
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (BuildContext context, GoRouterState state) {
        return DetailStory(
          storyId: state.pathParameters['id']!,
        );
      },
    ),
    GoRoute(
      path: '/add',
      builder: (BuildContext context, GoRouterState state) {
        return const AddStory();
      },
    ),
  ],
);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StoryApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
