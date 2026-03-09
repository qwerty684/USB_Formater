import 'package:flutter_test/flutter_test.dart';
import 'package:usb_formater/core/utils/volume_name_validator.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/formatting_progress.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/features/usb_format/domain/exceptions/usb_format_exceptions.dart';
import 'package:usb_formater/features/usb_format/domain/repositories/usb_format_repository.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_controller.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_feedback.dart';

void main() {
  group('UsbFormatController', () {
    test('ucitava uredaje i bira prvi dostupni uredaj', () async {
      final repository = FakeUsbFormatRepository(devices: [usbA, usbB]);
      final controller = UsbFormatController(repository);

      await Future<void>.delayed(Duration.zero);

      expect(controller.state.devices, hasLength(2));
      expect(controller.state.selectedDevice?.id, usbA.id);
      expect(controller.state.feedback, isNull);
    });

    test('unsupported discovery prijavljuje odgovarajuci feedback', () async {
      final repository = FakeUsbFormatRepository(
        loadDevicesException: const UsbDeviceDiscoveryUnsupportedException(),
      );
      final controller = UsbFormatController(repository);

      await Future<void>.delayed(Duration.zero);

      expect(
        controller.state.feedback,
        UsbFormatFeedback.deviceDiscoveryUnsupported,
      );
      expect(controller.state.devices, isEmpty);
    });

    test('validacija vraca gresku kada uredaj nije izabran', () async {
      final repository = FakeUsbFormatRepository(devices: const []);
      final controller = UsbFormatController(repository);

      await Future<void>.delayed(Duration.zero);

      final result = controller.validateBeforeFormatting();

      expect(result, UsbFormatFeedback.deviceRequired);
      expect(controller.state.feedback, UsbFormatFeedback.deviceRequired);
    });

    test('validacija volumena hvata nedozvoljene karaktere', () async {
      final repository = FakeUsbFormatRepository(devices: [usbA]);
      final controller = UsbFormatController(repository);

      await Future<void>.delayed(Duration.zero);
      controller.updateVolumeName('BAD/NAME');

      expect(
        controller.state.volumeNameError,
        VolumeNameValidationError.invalidCharacters,
      );
      expect(
        controller.validateBeforeFormatting(),
        UsbFormatFeedback.volumeNameInvalid,
      );
    });

    test(
      'prosledjuje format, trimovan volumen i quick format repo-u',
      () async {
        final repository = FakeUsbFormatRepository(
          devices: [usbA],
          progressEvents: const [
            FormattingProgress(
              progress: 0.2,
              stage: FormattingStage.preparingDevice,
            ),
            FormattingProgress(progress: 1, stage: FormattingStage.completed),
          ],
        );
        final controller = UsbFormatController(repository);

        await Future<void>.delayed(Duration.zero);
        controller.selectFormat(FileSystemFormat.refs);
        controller.toggleQuickFormat(false);
        controller.updateVolumeName('  WORK_DISK  ');

        final success = await controller.startFormatting();

        expect(success, isTrue);
        expect(repository.lastCall, isNotNull);
        expect(repository.lastCall?.format, FileSystemFormat.refs);
        expect(repository.lastCall?.volumeName, 'WORK_DISK');
        expect(repository.lastCall?.quickFormat, isFalse);
        expect(controller.state.lastOperationSuccessful, isTrue);
        expect(controller.state.formatProgress, 1);
        expect(controller.state.formatStage, FormattingStage.completed);
        expect(controller.state.isFormatting, isFalse);
      },
    );

    test('greska u repo-u vraca formatting failed feedback', () async {
      final repository = FakeUsbFormatRepository(
        devices: [usbA],
        formatException: Exception('boom'),
      );
      final controller = UsbFormatController(repository);

      await Future<void>.delayed(Duration.zero);

      final success = await controller.startFormatting();

      expect(success, isFalse);
      expect(controller.state.isFormatting, isFalse);
      expect(controller.state.feedback, UsbFormatFeedback.formattingFailed);
      expect(controller.state.lastOperationSuccessful, isFalse);
    });
  });
}

class FakeUsbFormatRepository implements UsbFormatRepository {
  FakeUsbFormatRepository({
    this.devices = const [],
    this.loadDevicesException,
    this.formatException,
    this.progressEvents,
  });

  final List<UsbDevice> devices;
  final Exception? loadDevicesException;
  final Exception? formatException;
  final List<FormattingProgress>? progressEvents;

  FormatInvocation? lastCall;

  @override
  Future<List<UsbDevice>> getAvailableDevices() async {
    if (loadDevicesException != null) {
      throw loadDevicesException!;
    }

    return devices;
  }

  @override
  Stream<FormattingProgress> formatDevice({
    required UsbDevice device,
    required FileSystemFormat format,
    required String? volumeName,
    required bool quickFormat,
  }) async* {
    lastCall = FormatInvocation(
      device: device,
      format: format,
      volumeName: volumeName,
      quickFormat: quickFormat,
    );

    if (formatException != null) {
      throw formatException!;
    }

    final events =
        progressEvents ??
        const [
          FormattingProgress(
            progress: 0.1,
            stage: FormattingStage.preparingDevice,
          ),
          FormattingProgress(progress: 1, stage: FormattingStage.completed),
        ];

    for (final event in events) {
      yield event;
    }
  }
}

class FormatInvocation {
  const FormatInvocation({
    required this.device,
    required this.format,
    required this.volumeName,
    required this.quickFormat,
  });

  final UsbDevice device;
  final FileSystemFormat format;
  final String? volumeName;
  final bool quickFormat;
}

const usbA = UsbDevice(
  id: 'a',
  name: 'USB A',
  capacityGb: 32,
  currentFormat: 'exFAT',
  isConnected: true,
);

const usbB = UsbDevice(
  id: 'b',
  name: 'USB B',
  capacityGb: 64,
  currentFormat: 'NTFS',
  isConnected: true,
);
