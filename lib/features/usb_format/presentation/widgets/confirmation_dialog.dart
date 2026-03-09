import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.device,
    required this.format,
    required this.volumeName,
    required this.quickFormatEnabled,
    super.key,
  });

  final UsbDevice device;
  final FileSystemFormat format;
  final String volumeName;
  final bool quickFormatEnabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final normalizedVolumeName = volumeName.trim();

    return AlertDialog(
      icon: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.primaryActionGradient,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(l10n.confirmationTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.confirmationMessage,
            style: AppTextStyles.cardSubtitle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 18),
          _SummaryRow(label: l10n.deviceLabel, value: device.name),
          _SummaryRow(label: l10n.formatLabel, value: format.displayName),
          _SummaryRow(
            label: l10n.volumeLabel,
            value: normalizedVolumeName.isEmpty
                ? l10n.defaultVolumeName
                : normalizedVolumeName,
          ),
          _SummaryRow(
            label: l10n.quickFormatLabel,
            value: quickFormatEnabled ? l10n.enabledLabel : l10n.disabledLabel,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
          ),
          child: Text(l10n.formatAction),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 118,
            child: Text(
              label,
              style: AppTextStyles.cardSubtitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.cardTitle.copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
