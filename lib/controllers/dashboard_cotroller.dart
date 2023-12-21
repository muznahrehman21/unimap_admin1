import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  RxString totalUsers = ''.obs;
  RxString totalPosts = ''.obs;
  RxString totalLocations = ''.obs;
  final StreamController<List<DocumentSnapshot>> _controller = StreamController.broadcast();

  @override
  void onInit() {
    getCounts();
    super.onInit();
  }
  getCounts()async{
    FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
      _controller.add(snapshot.docs);
      totalUsers.value = snapshot.docs.length.toString();
    }, onError: (error) {
      _controller.addError(error);
    });
    FirebaseFirestore.instance.collection('locations').snapshots().listen((snapshot) {
      _controller.add(snapshot.docs);
      totalLocations.value = snapshot.docs.length.toString();
    }, onError: (error) {
      _controller.addError(error);
    });
    FirebaseFirestore.instance.collection('posts').snapshots().listen((snapshot) {
      _controller.add(snapshot.docs);
      totalPosts.value = snapshot.docs.length.toString();
    }, onError: (error) {
      _controller.addError(error);
    });

  }
}