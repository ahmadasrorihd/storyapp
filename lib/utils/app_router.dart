import 'package:go_router/go_router.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/screens/add_story.dart';
import 'package:story_app/screens/detail_story.dart';
import 'package:story_app/screens/list_story.dart';
import 'package:story_app/screens/login.dart';
import 'package:story_app/screens/register.dart';
import 'package:story_app/utils/route_utils.dart';

class AppRouter {
  late final AuthProvider appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: APP_PAGE.home.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.home.toPath,
        name: APP_PAGE.home.toName,
        builder: (context, state) => const ListStory(),
      ),
      GoRoute(
        path: APP_PAGE.login.toPath,
        name: APP_PAGE.login.toName,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: APP_PAGE.register.toPath,
        name: APP_PAGE.register.toName,
        builder: (context, state) => const Register(),
      ),
      GoRoute(
        path: APP_PAGE.add.toPath,
        name: APP_PAGE.add.toName,
        builder: (context, state) => const AddStory(),
      ),
      GoRoute(
        path: APP_PAGE.detail.toPath,
        name: APP_PAGE.detail.toName,
        builder: (context, state) => const DetailStory(
          storyId: "2",
        ),
      )
    ],
    redirect: (context, state) {
      final loginLocation = state.namedLocation(APP_PAGE.login.toName);
      final homeLocation = state.namedLocation(APP_PAGE.home.toName);
      final isLogedIn = appService.loginState;

      if (isLogedIn) {
        homeLocation;
      } else {
        loginLocation;
      }
      return null;
    },
  );
}
