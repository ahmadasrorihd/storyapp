import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/api_client.dart';
import 'package:story_app/models/add_story.dart';
import 'package:story_app/providers/api_provider.dart';
import 'package:story_app/utils/validator.dart';

class AddStory extends StatefulWidget {
  const AddStory({super.key});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool isSubmit = false;
  bool isShareLocation = false;
  bool isLocationExist = false;
  String address = "";
  String result = "";

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
    if (provider.imageFile != null) {
      if (_formKey.currentState!.validate()) {
        try {
          if (result.isEmpty) {
            AddStoryResult res = await _apiClient.addStory(
              provider.imageFile!,
              descriptionController.text,
            );
            if (!res.error) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(res.message),
                  backgroundColor: Colors.green.shade300,
                ));
                context.pop(context);
                provider.setImagePath(null);
              }
            }
          } else {
            AddStoryResult res = await _apiClient.addStoryWithLocation(
              provider.imageFile!,
              descriptionController.text,
              convertLat(result),
              convertLon(result),
            );
            if (!res.error) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(res.message),
                  backgroundColor: Colors.green.shade300,
                ));
                context.pop(context);
                provider.setImagePath(null);
              }
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
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Harap pilih gambar terlebih dahulu"),
          backgroundColor: Colors.red.shade300,
        ));
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

  LatLng? convertStringToLatLng(String locationString) {
    List<String> parts = locationString
        .split(','); // Split the string using a comma as the separator
    if (parts.length == 2) {
      double? latitude = double.tryParse(parts[0].trim());
      double? longitude = double.tryParse(parts[1].trim());

      if (latitude != null && longitude != null) {
        return LatLng(latitude, longitude);
      }
    }
    // Handle invalid input or parsing errors
    return null;
  }

  double? convertLat(String locationString) {
    List<String> parts = locationString
        .split(','); // Split the string using a comma as the separator
    if (parts.length == 2) {
      double? latitude = double.tryParse(parts[0].trim());
      if (latitude != null) {
        return latitude;
      }
    }
    // Handle invalid input or parsing errors
    return null;
  }

  double? convertLon(String locationString) {
    List<String> parts = locationString
        .split(','); // Split the string using a comma as the separator
    if (parts.length == 2) {
      double? longitude = double.tryParse(parts[1].trim());

      if (longitude != null) {
        return longitude;
      }
    }
    // Handle invalid input or parsing errors
    return null;
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
                      validator: (value) {
                        return Validator.validateText(
                            value ?? "", 'Description');
                      },
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
                    height: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      String? val = await context.pushNamed('location');
                      setState(() {
                        result = val.toString();
                        isLocationExist = true;
                        LatLng locationResult =
                            convertStringToLatLng(val.toString())!;
                        placemarkFromCoordinates(locationResult.latitude,
                                locationResult.longitude)
                            .then((value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              address =
                                  "${value[0].locality} ${value[0].subAdministrativeArea} ${value[0].administrativeArea}";
                            });
                          }
                        });
                      });
                    },
                    child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          isLocationExist ? address : "Add Location",
                          style: const TextStyle(color: Colors.grey),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
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
