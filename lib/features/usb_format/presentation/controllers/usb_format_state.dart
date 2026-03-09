import 'package:usb_formater/core/utils/volume_name_validator.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/formatting_progress.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_feedback.dart';

class UsbFormatState {
  const UsbFormatState({
    this.devices = const [],
    this.selectedDevice,
    this.selectedFormat = FileSystemFormat.exfat,
    this.volumeName = '',
    this.quickFormatEnabled = true,
    this.isLoadingDevices = true,
    this.isFormatting = false,
    this.formatProgress = 0,
    this.formatStage,
    this.feedback,
    this.volumeNameError,
    this.lastOperationSuccessful = false,
  });

  static const _unset = Object();

  final List<UsbDevice> devices;
  final UsbDevice? selectedDevice;
  final FileSystemFormat selectedFormat;
  final String volumeName;
  final bool quickFormatEnabled;
  final bool isLoadingDevices;
  final bool isFormatting;
  final double formatProgress;
  final FormattingStage? formatStage;
  final UsbFormatFeedback? feedback;
  final VolumeNameValidationError? volumeNameError;
  final bool lastOperationSuccessful;

  bool get hasDevices => devices.isNotEmpty;

  bool get canStartFormatting {
    return selectedDevice != null &&
        !isLoadingDevices &&
        !isFormatting &&
        volumeNameError == null;
  }

  UsbFormatState copyWith({
    List<UsbDevice>? devices,
    Object? selectedDevice = _unset,
    FileSystemFormat? selectedFormat,
    String? volumeName,
    bool? quickFormatEnabled,
    bool? isLoadingDevices,
    bool? isFormatting,
    double? formatProgress,
    Object? formatStage = _unset,
    Object? feedback = _unset,
    Object? volumeNameError = _unset,
    bool? lastOperationSuccessful,
  }) {
    return UsbFormatState(
      devices: devices ?? this.devices,
      selectedDevice: selectedDevice == _unset
          ? this.selectedDevice
          : selectedDevice as UsbDevice?,
      selectedFormat: selectedFormat ?? this.selectedFormat,
      volumeName: volumeName ?? this.volumeName,
      quickFormatEnabled: quickFormatEnabled ?? this.quickFormatEnabled,
      isLoadingDevices: isLoadingDevices ?? this.isLoadingDevices,
      isFormatting: isFormatting ?? this.isFormatting,
      formatProgress: formatProgress ?? this.formatProgress,
      formatStage: formatStage == _unset
          ? this.formatStage
          : formatStage as FormattingStage?,
      feedback: feedback == _unset
          ? this.feedback
          : feedback as UsbFormatFeedback?,
      volumeNameError: volumeNameError == _unset
          ? this.volumeNameError
          : volumeNameError as VolumeNameValidationError?,
      lastOperationSuccessful:
          lastOperationSuccessful ?? this.lastOperationSuccessful,
    );
  }
}
