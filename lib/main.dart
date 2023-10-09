import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/core/api_client.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/utils/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiProvider apiProvider;
  late AuthProvider authProvider;
  late StreamSubscription<bool> authSubscription;

  @override
  void initState() {
    apiProvider = ApiProvider(apiClient: ApiClient());
    authProvider = AuthProvider(widget.sharedPreferences);
    authSubscription = authProvider.onAuthStateChange.listen(onAuthStateChange);
    super.initState();
  }

  void onAuthStateChange(bool login) {
    authProvider.loginState = login;
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiProvider>(create: (_) => apiProvider),
        Provider<AuthProvider>(create: (_) => authProvider),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter =
              Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            title: "Router App",
            routeInformationParser: goRouter.routeInformationParser,
            routerDelegate: goRouter.routerDelegate,
          );
        },
      ),
    );
  }
}
