import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/features/usb_format/data/datasources/platform_usb_device_data_source.dart';
import 'package:usb_formater/features/usb_format/data/models/mock_usb_devices.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/formatting_progress.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/features/usb_format/domain/repositories/usb_format_repository.dart';

final usbFormatRepositoryProvider = Provider<UsbFormatRepository>(
  (ref) => UsbFormatRepositoryImpl(PlatformUsbDeviceDataSource()),
);

class UsbDeviceDiscoveryUnsupportedException implements Exception {
  const UsbDeviceDiscoveryUnsupportedException();
}

class UsbFormatRepositoryImpl implements UsbFormatRepository {
  UsbFormatRepositoryImpl(this._deviceDataSource);

  final PlatformUsbDeviceDataSource _deviceDataSource;

  @override
  Future<List<UsbDevice>> getAvailableDevices() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    if (!_deviceDataSource.supportsNativeScan) {
      throw const UsbDeviceDiscoveryUnsupportedException();
    }

    try {
      final devices = await _deviceDataSource.getConnectedDevices();
      return devices.map((device) => device.toEntity()).toList(growable: false);
    } on MissingPluginException {
      return _fallbackDevices();
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Stream<FormattingProgress> formatDevice({
    required UsbDevice device,
    required FileSystemFormat format,
    required String? volumeName,
    required bool quickFormat,
  }) async* {
    final steps = <FormattingProgress>[
      const FormattingProgress(
        progress: 0.08,
        stage: FormattingStage.preparingDevice,
      ),
      const FormattingProgress(
        progress: 0.34,
        stage: FormattingStage.erasingPartitions,
      ),
      const FormattingProgress(
        progress: 0.68,
        stage: FormattingStage.creatingFileSystem,
      ),
      const FormattingProgress(
        progress: 0.93,
        stage: FormattingStage.finishingProcess,
      ),
    ];

    final stepDuration = quickFormat
        ? const Duration(milliseconds: 450)
        : const Duration(milliseconds: 900);

    yield const FormattingProgress(
      progress: 0,
      stage: FormattingStage.starting,
    );

    for (final step in steps) {
      await Future<void>.delayed(stepDuration);
      yield step;
    }

    await Future<void>.delayed(
      quickFormat
          ? const Duration(milliseconds: 250)
          : const Duration(milliseconds: 500),
    );

    yield const FormattingProgress(
      progress: 1,
      stage: FormattingStage.completed,
    );
  }

  List<UsbDevice> _fallbackDevices() {
    return mockUsbDevices
        .where((device) => device.isConnected)
        .map((device) => device.toEntity())
        .toList(growable: false);
  }
}
