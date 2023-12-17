import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimap_admin/controllers/updates_controller.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final UpdatesController updatesController = Get.put(UpdatesController());
  TextEditingController textController = TextEditingController();
  String? selectedFile;
  List<String> files = [
    'Image',
    'File',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UpdatesController>(
        builder:(_){
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 200,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: selectedFile,
                    hint: const Text('Choose file type'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFile = newValue;
                      });
                    },
                    items: files.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (updatesController.file != null)
                    Text(updatesController.file!.path.split('/').last)
                  else
                    const Text('No file selected'),
                  const SizedBox(height: 20),
                  if (selectedFile != null)
                    ElevatedButton(
                      onPressed: () {
                        updatesController.pickFile();
                      },
                      child: const Text('Choose file'),
                    ),
                  if (updatesController.file != null)
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedFile == null || selectedFile!.isEmpty) {
                          Get.snackbar('Error', 'Select file type');
                        } else if (textController.text.isEmpty) {
                          Get.snackbar('Error', 'Enter description');
                        } else {
                          showDialog(context: context,
                              barrierDismissible: false,
                              builder: (context){
                            return const Center(child: CircularProgressIndicator(),);
                          });
                          await updatesController.pushUpdate(textController.text,
                              selectedFile!.toLowerCase());
                          textController.clear();
                          updatesController.clearFile();
                          selectedFile = null;
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Publish'),

                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
