import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {

  bool isScanning = false;

  // Stream of scanned BLE devices
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  // Scan for BLE devices
  Future<void> scanDevices() async {

    // 🔹 Request permissions
    if (!await Permission.bluetoothScan.request().isGranted) return;
    if (!await Permission.bluetoothConnect.request().isGranted) return;
    if (!await Permission.locationWhenInUse.request().isGranted) return;

    // 🔹 Start spinner
    isScanning = true;
    update();

    // 🔹 Stop previous scan if any
    await FlutterBluePlus.stopScan();

    // 🔹 Start scan
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
    );

    // 🔹 Stop spinner after scan ends
    await Future.delayed(const Duration(seconds: 10));
    isScanning = false;
    update();
  }

  // Connect to a BLE device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect(timeout: const Duration(seconds: 15));

    device.connectionState.listen((state) {
      if (state == BluetoothConnectionState.connected) {
        print("Connected to ${device.platformName}");
      } else if (state == BluetoothConnectionState.disconnected) {
        print("Disconnected from device");
      }
    });
  }
}
