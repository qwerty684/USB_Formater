import 'package:flutter/material.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class VolumeNameField extends StatelessWidget {
  const VolumeNameField({required this.controller, this.errorText, super.key});

  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: context.l10n.volumeNameHint,
        errorText: errorText,
      ),
    );
  }
}
