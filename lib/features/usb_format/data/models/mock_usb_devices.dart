import 'package:usb_formater/features/usb_format/data/models/usb_device_model.dart';

const mockUsbDevices = <UsbDeviceModel>[
  UsbDeviceModel(
    id: 'usb-drive',
    name: 'USB Drive',
    capacityGb: 16,
    currentFormat: 'exFAT',
    isConnected: true,
  ),
  UsbDeviceModel(
    id: 'kingston-datatraveler',
    name: 'Kingston DataTraveler',
    capacityGb: 32,
    currentFormat: 'FAT32',
    isConnected: true,
  ),
  UsbDeviceModel(
    id: 'sandisk-ultra',
    name: 'SanDisk Ultra',
    capacityGb: 64,
    currentFormat: 'NTFS',
    isConnected: true,
  ),
];
