import 'package:flutter/widgets.dart';
import 'package:story_app/screens/add_story.dart';
import 'package:story_app/screens/detail_story.dart';
import 'package:story_app/screens/list_story.dart';

import '../screens/login.dart';
import '../screens/register.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (context) => const Login(),
  Register.routeName: (context) => const Register(),
  ListStory.routeName: (context) => const ListStory(),
  DetailStory.routeName: (context) => const DetailStory(),
  AddStory.routeName: (context) => const AddStory(),
};
