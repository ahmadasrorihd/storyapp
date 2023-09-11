import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/screens/detail_story.dart';
import 'package:story_app/screens/list_story.dart';
import 'package:story_app/screens/login.dart';
import 'package:story_app/utils/constant.dart';
import 'package:story_app/utils/routes.dart';

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

class MyApp extends StatelessWidget {
  final bool? isLogin;
  const MyApp({
    Key? key,
    this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StoryApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:
          isLogin == null || false ? Login.routeName : ListStory.routeName,
      routes: routes,
      home: Navigator(
        pages: const [
          MaterialPage(key: ValueKey("StoryListPage"), child: ListStory()),
          MaterialPage(key: ValueKey("StoryListPage"), child: DetailStory(storyId: storyId,))
        ],
        onPopPage: (route, result) {},
      ),
    );
  }
}
