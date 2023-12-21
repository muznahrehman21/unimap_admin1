import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimap_admin/widgets/custom_textfield.dart';

import '../../../controllers/location_controller.dart';
import 'map_screen.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  late LocationController _locationController;

  @override
  void initState() {
    try {
      _locationController = Get.find<LocationController>();
    } catch (e) {
      _locationController = Get.put(LocationController());
    }
    _locationController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
        backgroundColor: Colors.deepPurple,
      ),
      body: GetBuilder<LocationController>(
        builder: (_) => Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                labelText: 'Location Name',
                controller: _locationController.locationNameController,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint:  Text(_locationController.selectedFloor),
                  items: _locationController.floors
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _locationController.selectedFloor = value.toString();
                  },
                ),
              ),
            ),
            ListTile(
              contentPadding:  EdgeInsets.zero,
              leading: Checkbox(
                  activeColor: Colors.deepPurple,
                  value: _locationController.forDisabled,
                  onChanged: (value) {
                    _locationController.forDisabled = value!;
                  }),
              title: const Text('For Disabled'),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _locationController.showButton = true;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Use Current Location'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseFromMap()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Choose from Map'),
                    ),
                  ),
                ),
              ],
            ),
            if(_locationController.showButton)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder:(context) => const Center(child: CircularProgressIndicator(),));
                 await _locationController.addLocation().then((value) {
                   Navigator.pop(context);
                 });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
