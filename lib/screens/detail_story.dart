import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/api_provider.dart';

class DetailStory extends StatefulWidget {
  final String storyId;
  const DetailStory({super.key, required this.storyId});

  @override
  State<DetailStory> createState() => _DetailStoryState();
}

class _DetailStoryState extends State<DetailStory> {
  String address = "";
  @override
  void initState() {
    super.initState();

    final dataProvider = Provider.of<ApiProvider>(context, listen: false);
    dataProvider.detailStory(widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Story'),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, data, child) {
          if (data.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var story = data.detailStoryResult.story;
            if (story.lat != null && story.lon != null) {
              placemarkFromCoordinates(story.lat!, story.lon!).then((value) {
                if (value.isNotEmpty) {
                  setState(() {
                    address =
                        "${value[0].street} ${value[0].subLocality} ${value[0].locality} ${value[0].subAdministrativeArea} ${value[0].administrativeArea} ${value[0].postalCode} ${value[0].country}";
                  });
                }
              });
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(story.photoUrl,
                      fit: BoxFit.cover, height: 250, width: double.infinity),
                  if (story.lat != null && story.lon != null)
                    SizedBox(
                      height: 250,
                      child: GoogleMap(
                          markers: {
                            Marker(
                              markerId: MarkerId(story.id),
                              position: LatLng(story.lat!, story.lon!),
                              infoWindow: InfoWindow(
                                title: address,
                              ), // InfoWindow
                            )
                          },
                          initialCameraPosition: CameraPosition(
                              zoom: 18,
                              target: LatLng(story.lat!, story.lon!))),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          story.name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                            .format(story.createdAt)),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(story.description),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
