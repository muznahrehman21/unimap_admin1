import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimap_admin/views/auth/login_screen.dart';
import 'package:unimap_admin/views/bottom_nav/bottom_nav.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  goNext(){
    Future.delayed(const Duration(seconds: 3), () async{
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
      }
    } );
  }
  @override
  void initState() {
    goNext();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(
              size: 200,

            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
