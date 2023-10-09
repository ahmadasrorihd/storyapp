enum APP_PAGE { login, register, home, add, detail }

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.home:
        return "/";
      case APP_PAGE.login:
        return "/login";
      case APP_PAGE.register:
        return "/register";
      case APP_PAGE.add:
        return "/add";
      case APP_PAGE.detail:
        return "/detail:storyId";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.login:
        return "LOGIN";
      case APP_PAGE.register:
        return "REGISTER";
      case APP_PAGE.add:
        return "ADD";
      case APP_PAGE.detail:
        return "DETAIL";
      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case APP_PAGE.home:
        return "StoryApp";
      case APP_PAGE.login:
        return "Login";
      case APP_PAGE.register:
        return "Register";
      case APP_PAGE.add:
        return "Add";
      case APP_PAGE.detail:
        return "Detail";
      default:
        return "StoryApp";
    }
  }
}
