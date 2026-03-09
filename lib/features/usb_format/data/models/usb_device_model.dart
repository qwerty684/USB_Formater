import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';

class UsbDeviceModel extends UsbDevice {
  const UsbDeviceModel({
    required super.id,
    required super.name,
    required super.capacityGb,
    required super.currentFormat,
    required super.isConnected,
  });

  UsbDevice toEntity() {
    return UsbDevice(
      id: id,
      name: name,
      capacityGb: capacityGb,
      currentFormat: currentFormat,
      isConnected: isConnected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'capacityGb': capacityGb,
      'currentFormat': currentFormat,
      'isConnected': isConnected,
    };
  }

  factory UsbDeviceModel.fromJson(Map<String, dynamic> json) {
    return UsbDeviceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      capacityGb: json['capacityGb'] as int,
      currentFormat: json['currentFormat'] as String? ?? 'Nepoznat',
      isConnected: json['isConnected'] as bool,
    );
  }
}
