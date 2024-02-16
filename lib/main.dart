import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScree(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  List smartDevices = [
    ['Smart Light', 'lib/icons/light-bulb.png', true],
    ['Smart Fun', 'lib/icons/fan.png', false],
    ['Smart TV', 'lib/icons/smart-tv.png', false],
    ['Smart AC', 'lib/icons/air-conditioner.png', false],
    // ['Smart Doorbell', 'lib/icons/doorbell.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'lib/icons/menu.png',
                    height: 50,
                    color: Colors.grey[800],
                  ),
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[800],
                  )
                ],
              ),
            ),
            // const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                  itemCount: smartDevices.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return SmartDeviceBox(
                      smartDeviceName: smartDevices[index][0],
                      smartDeviceIcon: smartDevices[index][1],
                      isOn: smartDevices[index][2],
                      onChanged: (value) {
                        setState(() {
                          smartDevices[index][2] = value;
                        });
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class SmartDeviceBox extends StatelessWidget {
  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.smartDeviceIcon,
    required this.isOn,
    required this.onChanged,
  });

  final String smartDeviceName;
  final String smartDeviceIcon;
  final bool isOn;
  void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: isOn ? Colors.grey[200] : Colors.grey[800],
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, bottom: 10),
              child: Image.asset(
                smartDeviceIcon,
                height: 65,
                color: isOn ? Colors.grey[800] : Colors.grey[200],
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      smartDeviceName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isOn ? Colors.grey[800] : Colors.grey[200],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 10),
                Transform.rotate(
                  angle: pi / 2,
                  child: CupertinoSwitch(
                    value: isOn,
                    onChanged: onChanged,
                    activeColor: isOn ? Colors.grey[600] : Colors.grey[100],
                    trackColor: isOn ? Colors.grey[600] : Colors.grey[100],
                    thumbColor: isOn ? Colors.grey[200] : Colors.grey[800],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
