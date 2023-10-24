import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/screens/add_location.dart';
import 'package:story_app/screens/add_story.dart';
import 'package:story_app/screens/detail_story.dart';
import 'package:story_app/screens/list_story.dart';
import 'package:story_app/screens/login.dart';
import 'package:story_app/screens/register.dart';
import 'package:story_app/screens/splashscreen.dart';

import 'core/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiProvider(apiClient: ApiClient()))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final GoRouter _router;

  MyApp({
    Key? key,
  })  : _router = GoRouter(
          routes: [
            GoRoute(
              path: "/",
              name: 'splashscreen',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: "/login",
              name: 'login',
              builder: (context, state) => const Login(),
            ),
            GoRoute(
                path: "/register",
                name: 'register',
                builder: (context, state) => const Register()),
            GoRoute(
                path: "/list",
                name: 'list',
                builder: (context, state) => const ListStoryPage()),
            GoRoute(
                path: "/add",
                name: 'add',
                builder: (context, state) => const AddStory()),
            GoRoute(
                path: "/location",
                name: 'location',
                builder: (context, state) => const AddLocation()),
            GoRoute(
                path: "/detail/:storyId",
                name: 'detail',
                builder: (context, state) => DetailStory(
                      storyId: state.pathParameters['storyId']!,
                    )),
          ],
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "StoryApp",
      routerConfig: _router,
    );
  }
}
