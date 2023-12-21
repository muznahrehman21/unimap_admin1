import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimap_admin/controllers/user_controller.dart';

import 'add_location.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserController _userController;
  @override
  void initState() {
   try{
     _userController = Get.find<UserController>();}
    catch(e){
     _userController = Get.put(UserController());
   }
    super.initState();
  }
  File? _profileImage;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  // backgroundImage: _profileImage != null
                  //     ? FileImage(_profileImage!)
                  //     : const AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.grey[300],
                  radius: 50,
                  child: const Icon(Icons.person, size: 50, color: Colors.deepPurple),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Admin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            ListTile(
              leading: const Icon(Icons.location_on_outlined, color: Colors.deepPurple),
              title: const Text('Add Location'),
              trailing: const Icon(Icons.arrow_forward_ios,),
              onTap: () {

                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddLocationScreen(),
                  ),);
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              leading: const Icon(Icons.logout_outlined, color: Colors.deepPurple),
              title: const Text('Logout'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            _userController.signOut(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            // Add other widgets here if needed
          ],
        ),
      ),
    );
  }
}
