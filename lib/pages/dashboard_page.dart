// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/controller/bluetooth_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BluetoothController>(
        init: BluetoothController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // 🔹 Header
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Bluetooth Scanner',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 🔹 Scan Button / Animation
                Center(
                  child: controller.isScanning
                      ? Column(
                          children: const [
                            CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Scanning for devices...',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: controller.scanDevices,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(200, 55),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Scan',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                // 🔹 BLE Devices List
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (controller.isScanning) {
                      // Hide device list while scanning
                      return const SizedBox.shrink();
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final devices = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          final device = devices[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                device.device.platformName.isNotEmpty
                                    ? device.device.platformName
                                    : 'Unknown Device',
                              ),
                              subtitle: Text(
                                device.device.remoteId.toString(),
                              ),
                              trailing: Text('RSSI: ${device.rssi}'),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching devices');
                    } else {
                      // Show only when scan finished and no devices found
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('No devices found'),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
