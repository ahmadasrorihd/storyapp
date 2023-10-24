import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/models/add_story.dart';
import 'package:story_app/models/detail_story.dart';

import '../core/api_client.dart';

class ApiProvider with ChangeNotifier {
  final ApiClient apiClient;
  ApiProvider({required this.apiClient});

  late DetailStoryResult _detailStoryResult;
  late AddStoryResult _addStoryResult;

  XFile? imageFile;
  String? imagePath;

  bool _loading = false;
  final ApiClient _apiClient = ApiClient();
  String _errorMessage = '';

  DetailStoryResult get detailStoryResult => _detailStoryResult;
  AddStoryResult get addStoryResult => _addStoryResult;

  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  Future detailStory(String id) async {
    _loading = true;
    try {
      _detailStoryResult = await _apiClient.detailStory(id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
