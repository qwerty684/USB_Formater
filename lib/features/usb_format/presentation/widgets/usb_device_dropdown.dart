import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class UsbDeviceDropdown extends StatelessWidget {
  const UsbDeviceDropdown({
    required this.selectedDevice,
    required this.isLoading,
    required this.onTap,
    this.isDesktop = false,
    super.key,
  });

  final UsbDevice? selectedDevice;
  final bool isLoading;
  final VoidCallback onTap;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final boxSize = isDesktop ? 88.0 : 44.0;
    final boxRadius = isDesktop ? 26.0 : 14.0;
    final padding = isDesktop ? 28.0 : 14.0;
    final titleStyle = AppTextStyles.cardTitle.copyWith(
      fontSize: isDesktop ? 22 : 16,
    );
    final subtitleStyle = AppTextStyles.cardSubtitle.copyWith(
      fontSize: isDesktop ? 16 : 13,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(isDesktop ? 28 : 18),
        child: Ink(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(isDesktop ? 28 : 18),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(boxRadius),
                ),
                child: Icon(
                  Icons.usb_rounded,
                  color: AppColors.primaryPurple,
                  size: isDesktop ? 38 : 24,
                ),
              ),
              SizedBox(width: isDesktop ? 20 : 12),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: isLoading
                      ? Column(
                          key: const ValueKey('loading'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.searchingDevices, style: titleStyle),
                            SizedBox(height: isDesktop ? 6 : 2),
                            Text(l10n.pleaseWait, style: subtitleStyle),
                          ],
                        )
                      : selectedDevice == null
                      ? Column(
                          key: const ValueKey('empty'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.noSelectedDevice, style: titleStyle),
                            SizedBox(height: isDesktop ? 6 : 2),
                            Text(
                              l10n.tapToChooseUsbDevice,
                              style: subtitleStyle,
                            ),
                          ],
                        )
                      : Column(
                          key: ValueKey(selectedDevice!.id),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(selectedDevice!.name, style: titleStyle),
                            SizedBox(height: isDesktop ? 6 : 2),
                            Text(
                              selectedDevice!.metadata,
                              style: subtitleStyle,
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(width: isDesktop ? 16 : 8),
              isLoading
                  ? SizedBox(
                      width: isDesktop ? 28 : 22,
                      height: isDesktop ? 28 : 22,
                      child: CircularProgressIndicator(strokeWidth: 2.2),
                    )
                  : Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                      size: isDesktop ? 42 : 28,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
