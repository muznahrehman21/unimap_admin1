import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController{
  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }
  bool _showButton = false;

  bool get showButton => _showButton;

  set showButton(bool value) {
    _showButton = value;
    update();
  }

  final TextEditingController locationNameController = TextEditingController();
  bool _forDisabled = false;

  bool mapLoading = false;

  bool get forDisabled => _forDisabled;

  String _selectedFloor = 'Select Floor';

  String get selectedFloor => _selectedFloor;

  set selectedFloor(String value) {
    _selectedFloor = value;
    update();
  }

  set forDisabled(bool value) {
    _forDisabled = value;
    update();
  }

  List<String> floors = ['Ground Floor','1st Floor', '2nd Floor', '3rd Floor', '4th Floor'];

  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  LatLng initialPosition =
  const LatLng(45.521563, -122.677433);
  LatLng? fetchedLocation; // Default position

  Future<void> onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
  }

  Future<void> getCurrentLocation() async {
    mapLoading = true;
    update();
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      final geoposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final position = LatLng(geoposition.latitude, geoposition.longitude);
      initialPosition = position;
      fetchedLocation = position;// Update initial position
      markers.add(Marker(
          markerId: const MarkerId('1'),
          position: position,
          infoWindow: const InfoWindow(title: 'Your Location')));
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: position,
        zoom: 11.0,
      )));
      mapLoading = false;
      update();
    } else {
      // Handle permission denied case
    }
  }

  Future<void> addLocation() async {
    if(locationNameController.text.isEmpty){
      Get.snackbar('Error', 'Please enter location name');
      return;
    }
    if(selectedFloor == 'Select Floor'){
      Get.snackbar('Error', 'Please select floor');
      return;
    }

    if(locationNameController.text.isNotEmpty && selectedFloor != 'Select Floor'){
      final locationsCollection = FirebaseFirestore.instance.collection('locations');

      await locationsCollection.add({
        'floor': selectedFloor,
        'name': locationNameController.text,
        'forDisabled': forDisabled,
        'points': GeoPoint(fetchedLocation!.latitude, fetchedLocation!.longitude),
        'createdAt': DateTime.now(),
      });
      Get.snackbar('Success', 'Location added successfully');
      clear();
    }
  }

  addMarkerOnTap(LatLng latLng){
      fetchedLocation = latLng;
      markers.clear();
      markers.add(Marker(
          markerId: const MarkerId('1'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'Added Location')));
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: latLng,
        zoom: 11.0,
      )));
      showButton = true;
      update();
      Get.back();
  }

  clear(){
    showButton = false;
    locationNameController.clear();
    selectedFloor = 'Select Floor';
    forDisabled = false;
    update() ;
  }
}