import 'package:usb_formater/core/constants/app_constants.dart';

enum VolumeNameValidationError { tooLong, invalidCharacters }

class VolumeNameValidator {
  const VolumeNameValidator._();

  static VolumeNameValidationError? validate(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return null;
    }

    if (trimmed.length > AppConstants.maxVolumeNameLength) {
      return VolumeNameValidationError.tooLong;
    }

    if (AppConstants.invalidVolumeNamePattern.hasMatch(trimmed)) {
      return VolumeNameValidationError.invalidCharacters;
    }

    return null;
  }
}
