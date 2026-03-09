import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:usb_formater/features/usb_format/data/models/usb_device_model.dart';

class PlatformUsbDeviceDataSource {
  PlatformUsbDeviceDataSource({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('usb_formater/device_scanner');

  final MethodChannel _channel;

  bool get supportsNativeScan {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;
  }

  Future<List<UsbDeviceModel>> getConnectedDevices() async {
    final rawDevices = await _channel.invokeMethod<List<dynamic>>(
      'getConnectedDevices',
    );

    if (rawDevices == null) {
      return const [];
    }

    return rawDevices
        .whereType<Map<dynamic, dynamic>>()
        .map(
          (device) =>
              device.map((key, value) => MapEntry(key.toString(), value)),
        )
        .map(UsbDeviceModel.fromJson)
        .toList(growable: false);
  }
}
