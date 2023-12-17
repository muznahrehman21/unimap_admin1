import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UpdatesController extends GetxController {
  RxBool isImage = false.obs;
  bool isLoading = false;
  File? file;

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
    );
    if (result != null) {
      file = File(result.files.single.path!);
      isImage.value = true;
    } else {}
    update();
  }

  clearFile() {
    file = null;
    isImage.value = false;
    update();
  }

  Future<void> pushUpdate(String description, String type) async {
    try {
      String filePath = 'updates/${file!.path.split('/').last}';
      TaskSnapshot uploadTask =
          await FirebaseStorage.instance.ref(filePath).putFile(file!);
      String imageUrl = await uploadTask.ref.getDownloadURL();

      final userRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      await userRef.set({
        'url': imageUrl,
        'description': description,
        'type': type,
        'createdAt': DateTime.now(),
      });
      isLoading = false;

      Get.snackbar('Success', 'Post created successfully');
    } catch (e) {
      isLoading = false;
      Get.snackbar('Error', 'Profile image update failed');
    }
  }
}
