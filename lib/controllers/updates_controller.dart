import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UpdatesController extends GetxController{
  RxBool isImage = false.obs;
  File? file;
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
    );
    if(result != null) {
       file = File(result.files.single.path!);
       isImage.value = true;
    } else {

    }
    update();
  }
  clearFile(){
    file = null;
    isImage.value = false;
    update();
  }
}