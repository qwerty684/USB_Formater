import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/formatting_progress.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';

abstract class UsbFormatRepository {
  Future<List<UsbDevice>> getAvailableDevices();

  Stream<FormattingProgress> formatDevice({
    required UsbDevice device,
    required FileSystemFormat format,
    required String? volumeName,
    required bool quickFormat,
  });
}
