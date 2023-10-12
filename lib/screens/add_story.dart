import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/api_client.dart';
import 'package:story_app/models/add_story.dart';
import 'package:story_app/providers/api_provider.dart';

class AddStory extends StatefulWidget {
  static String routeName = "/add";
  const AddStory({super.key});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool isSubmit = false;

  _onGalleryView() async {
    final provider = context.read<ApiProvider>();
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<ApiProvider>();
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onSubmitStory() async {
    final provider = context.read<ApiProvider>();

    if (_formKey.currentState!.validate()) {
      try {
        AddStoryResult res = await _apiClient.addStory(
            provider.imageFile!, descriptionController.text);
        if (!res.error) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(res.message),
              backgroundColor: Colors.green.shade300,
            ));
            context.pop(context);
          }
        }
      } on DioException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.response!.data.toString()),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
    setState(() {
      isSubmit = false;
    });
  }

  Widget _showImage() {
    final imagePath = context.read<ApiProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Story'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.watch<ApiProvider>().imagePath == null
                      ? Container(
                          height: 120,
                          width: 120,
                          color: Colors.black,
                        )
                      : _showImage(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        height: 46.0,
                        minWidth: 100,
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          _onCameraView();
                        },
                        child: const Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      MaterialButton(
                        height: 46.0,
                        minWidth: 100,
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          _onGalleryView();
                        },
                        child: const Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 120,
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Description",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isSubmit
                      ? const CircularProgressIndicator()
                      : MaterialButton(
                          height: 46.0,
                          minWidth: double.infinity,
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              isSubmit = true;
                            });
                            _onSubmitStory();
                          },
                          child: const Text(
                            "Upload",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              )),
        ),
      ),
    );
  }
}
