import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/tabs/dashboard_screen.dart';
import '../views/tabs/profile_screen.dart';
import '../views/tabs/update_screen.dart';

class BottomNavController extends GetxController {
@override
  void onInit(){
  super.onInit();
}
final _selectedIndex=0.obs;

  get selectedIndex => _selectedIndex.value;

  void changeIndex(int index){
_selectedIndex.value=index;
}

List<Widget> screens=[
  const DashBoard(),
  const UpdateScreen(),

//  const ProfileScreen(),
];
}

