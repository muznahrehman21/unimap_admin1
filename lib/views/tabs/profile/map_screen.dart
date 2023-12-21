import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/location_controller.dart';

class ChooseFromMap extends StatefulWidget {
  const ChooseFromMap({super.key});

  @override
  State<ChooseFromMap> createState() => _ChooseFromMapState();
}

class _ChooseFromMapState extends State<ChooseFromMap> {
   LocationController _locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LocationController>(
          init: _locationController,
          builder: (controller) => _locationController.mapLoading
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Loading Map..."),
              ],
            ),
          )
              : GoogleMap(
            onMapCreated: _locationController.onMapCreated,
            myLocationEnabled: true,
            onTap: (LatLng location) {
              _locationController.addMarkerOnTap(location);
            },
            initialCameraPosition: CameraPosition(
              target: _locationController.initialPosition,
              zoom: 13.4,
            ),
            markers: _locationController.markers,
          ),
        ));
  }
}
