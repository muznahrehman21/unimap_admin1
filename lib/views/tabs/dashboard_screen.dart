import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    // A list of gradients to be used for each box
    final gradients = [
      const LinearGradient(
        colors: [
          Color.fromRGBO(0, 127, 255, 1.0),
          Color.fromRGBO(250, 128, 114, 1.0)
        ],
      ),
      const LinearGradient(
        colors: [
          Color.fromRGBO(30, 60, 114, 1.0),
          Color.fromRGBO(90, 200, 250, 1.0)
        ],
      ),
      const LinearGradient(
        colors: [
          Color.fromRGBO(199, 21, 133, 1.0),
          Color.fromRGBO(255, 69, 0, 1.0)
        ],
      ),
    ];

    // A list of texts to be used for each box
    final texts = ['Total Users', 'Total Posts', ''];

    return MaterialApp(
      title: 'Grid Demo',
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *
                0.5,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      _buildGradientBox(gradients[0], texts[0]),
                      _buildGradientBox(gradients[1], texts[1]),
                    ],
                  ),
                ),
                _buildGradientBox(gradients[2], 'Total Locations'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBox(LinearGradient gradient, String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8), // Spacing between boxes
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), // Rounded corners
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 23,

              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
