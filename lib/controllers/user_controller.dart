
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimap_admin/views/bottom_nav/bottom_nav.dart';

import '../views/auth/login_screen.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? _currentUser;
  RxString email = ''.obs;
  RxString password = ''.obs;

  UserCredential? userCredential;
  final Rxn<User> firebaseUser = Rxn<User>();

  String? get uid => _currentUser!.uid;

  Future<void> signInWithEmail(String email, String password, context) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    if(email != ('admin@unimapnav.com')){
      Get.snackbar('Error', 'Only admin can login');
      return;
    }
    try {
      userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value = userCredential!.user;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
    }
    catch(e){
      Get.snackbar('Error',e.toString() );
    }
  }
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut().then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
      });

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}

