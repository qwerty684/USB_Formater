import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/core/utils/volume_name_validator.dart';
import 'package:usb_formater/features/usb_format/data/repositories/mock_usb_format_repository.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/formatting_progress.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/features/usb_format/domain/repositories/usb_format_repository.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_feedback.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_state.dart';

final usbFormatControllerProvider =
    StateNotifierProvider<UsbFormatController, UsbFormatState>(
      (ref) => UsbFormatController(ref.watch(usbFormatRepositoryProvider)),
    );

class UsbFormatController extends StateNotifier<UsbFormatState> {
  UsbFormatController(this._repository) : super(const UsbFormatState()) {
    loadDevices();
  }

  final UsbFormatRepository _repository;

  Future<void> loadDevices() async {
    state = state.copyWith(
      isLoadingDevices: true,
      feedback: null,
      lastOperationSuccessful: false,
    );

    try {
      final devices = await _repository.getAvailableDevices();
      final selectedDevice = _resolveSelectedDevice(devices);

      state = state.copyWith(
        devices: devices,
        selectedDevice: selectedDevice,
        isLoadingDevices: false,
        feedback: null,
      );
    } on UsbDeviceDiscoveryUnsupportedException {
      state = state.copyWith(
        devices: const [],
        selectedDevice: null,
        isLoadingDevices: false,
        feedback: UsbFormatFeedback.deviceDiscoveryUnsupported,
      );
    } catch (_) {
      state = state.copyWith(
        devices: const [],
        selectedDevice: null,
        isLoadingDevices: false,
        feedback: UsbFormatFeedback.devicesLoadFailed,
      );
    }
  }

  Future<void> refreshDevices() => loadDevices();

  void selectDevice(UsbDevice device) {
    state = state.copyWith(selectedDevice: device, feedback: null);
  }

  void selectFormat(FileSystemFormat format) {
    state = state.copyWith(selectedFormat: format);
  }

  void updateVolumeName(String value) {
    state = state.copyWith(
      volumeName: value,
      volumeNameError: VolumeNameValidator.validate(value),
    );
  }

  void toggleQuickFormat(bool value) {
    state = state.copyWith(quickFormatEnabled: value);
  }

  UsbFormatFeedback? validateBeforeFormatting() {
    if (state.selectedDevice == null) {
      state = state.copyWith(feedback: UsbFormatFeedback.deviceRequired);
      return UsbFormatFeedback.deviceRequired;
    }

    final volumeNameError = VolumeNameValidator.validate(state.volumeName);
    if (volumeNameError != null) {
      state = state.copyWith(
        volumeNameError: volumeNameError,
        feedback: UsbFormatFeedback.volumeNameInvalid,
      );
      return UsbFormatFeedback.volumeNameInvalid;
    }

    state = state.copyWith(volumeNameError: null, feedback: null);
    return null;
  }

  Future<bool> startFormatting() async {
    final validationError = validateBeforeFormatting();
    if (validationError != null) {
      return false;
    }

    final device = state.selectedDevice;
    if (device == null) {
      return false;
    }

    state = state.copyWith(
      isFormatting: true,
      formatProgress: 0,
      formatStage: FormattingStage.starting,
      feedback: null,
      lastOperationSuccessful: false,
    );

    try {
      await for (final progress in _repository.formatDevice(
        device: device,
        format: state.selectedFormat,
        volumeName: state.volumeName.trim().isEmpty
            ? null
            : state.volumeName.trim(),
        quickFormat: state.quickFormatEnabled,
      )) {
        state = state.copyWith(
          formatProgress: progress.progress,
          formatStage: progress.stage,
        );
      }

      state = state.copyWith(
        isFormatting: false,
        lastOperationSuccessful: true,
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        isFormatting: false,
        feedback: UsbFormatFeedback.formattingFailed,
        lastOperationSuccessful: false,
      );
      return false;
    }
  }

  void consumeFeedback() {
    if (state.feedback == null) {
      return;
    }

    state = state.copyWith(feedback: null);
  }

  void clearFormattingFeedback() {
    state = state.copyWith(
      formatProgress: 0,
      formatStage: null,
      lastOperationSuccessful: false,
    );
  }

  UsbDevice? _resolveSelectedDevice(List<UsbDevice> devices) {
    final currentSelectionId = state.selectedDevice?.id;
    for (final device in devices) {
      if (device.id == currentSelectionId) {
        return device;
      }
    }
    if (devices.isEmpty) {
      return null;
    }
    return devices.first;
  }
}
