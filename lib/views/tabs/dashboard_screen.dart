import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimap_admin/controllers/dashboard_cotroller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DashboardController _dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    // A list of gradients to be used for each box
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height *
              0.5,
          child: Column(
            children: [
              Obx(
                  ()=> Wrap(
                  children: <Widget>[
                    _buildGradientBox( 'Total Users',_dashboardController.totalUsers.value.toString()),
                    _buildGradientBox('Total Posts',_dashboardController.totalPosts.value.toString()),
                    _buildGradientBox( 'Total Locations',_dashboardController.totalLocations.value.toString()),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBox( String text,String value) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.4, // Width of the box should be 40% of the screen width
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.all(8), // Spacing between boxes
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14), // Rounded corners
        gradient: const LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.deepPurpleAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
