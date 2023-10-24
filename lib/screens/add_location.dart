import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  late LatLng dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late String result;
  late GoogleMapController mapController;
  String address = "";
  int count = 0;
  Set<Marker> markers = {};

  void _addMarker(LatLng position) {
    setState(() {
      placemarkFromCoordinates(position.latitude, position.longitude)
          .then((value) {
        if (value.isNotEmpty) {
          setState(() {
            address =
                "${value[0].locality} ${value[0].subAdministrativeArea} ${value[0].administrativeArea}";
          });
        }
      });
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: address,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
        actions: [
          IconButton(
              onPressed: () {
                context.pop(result);
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Center(
        child: GoogleMap(
            markers: markers,
            onTap: (LatLng tappedPosition) {
              result =
                  "${tappedPosition.latitude}, ${tappedPosition.longitude}";
              _addMarker(tappedPosition);
            },
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            myLocationButtonEnabled: true,
            initialCameraPosition:
                CameraPosition(zoom: 18, target: dicodingOffice)),
      ),
    );
  }
}
