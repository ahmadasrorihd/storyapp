import 'package:flutter/cupertino.dart';
import 'package:story_app/models/list_story.dart';

import '../core/api_client.dart';

class ApiProvider with ChangeNotifier {
  final ApiClient apiClient;
  ApiProvider({required this.apiClient});

  late ListStoryResult _listStoryResult;

  bool _loading = false;
  final ApiClient _apiClient = ApiClient();
  String _errorMessage = '';

  ListStoryResult get listStoryResult => _listStoryResult;

  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  Future allStory() async {
    _loading = true;
    try {
      _listStoryResult = await _apiClient.allStory();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
