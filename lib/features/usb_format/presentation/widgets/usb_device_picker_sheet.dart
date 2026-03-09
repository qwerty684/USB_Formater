import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/empty_devices_state.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class UsbDevicePickerSheet extends StatelessWidget {
  const UsbDevicePickerSheet({
    required this.devices,
    required this.selectedDevice,
    required this.onSelected,
    required this.onRetry,
    this.isDesktopDialog = false,
    super.key,
  });

  final List<UsbDevice> devices;
  final UsbDevice? selectedDevice;
  final ValueChanged<UsbDevice> onSelected;
  final VoidCallback onRetry;
  final bool isDesktopDialog;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardInner,
        borderRadius: isDesktopDialog
            ? BorderRadius.circular(32)
            : const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: isDesktopDialog,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            isDesktopDialog ? 28 : 20,
            isDesktopDialog ? 24 : 12,
            isDesktopDialog ? 28 : 20,
            20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isDesktopDialog) ...[
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.handle,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),
              ],
              Text(
                l10n.availableUsbDevices,
                style: AppTextStyles.dialogTitle.copyWith(
                  fontSize: isDesktopDialog ? 28 : 20,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.chooseDeviceToFormat,
                textAlign: TextAlign.center,
                style: AppTextStyles.cardSubtitle,
              ),
              const SizedBox(height: 18),
              if (devices.isEmpty)
                EmptyDevicesState(onRetry: onRetry, isDesktop: isDesktopDialog)
              else
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: isDesktopDialog ? 460 : 380,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: devices.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      final isSelected = device.id == selectedDevice?.id;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => onSelected(device),
                          borderRadius: BorderRadius.circular(20),
                          child: Ink(
                            padding: EdgeInsets.all(isDesktopDialog ? 18 : 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryPurple.withValues(
                                      alpha: 0.08,
                                    )
                                  : AppColors.unselectedTileBackground,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.infoBorder
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: isDesktopDialog ? 56 : 46,
                                  height: isDesktopDialog ? 56 : 46,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryPurple.withValues(
                                      alpha: 0.14,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      isDesktopDialog ? 18 : 16,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.usb_rounded,
                                    color: AppColors.primaryPurple,
                                    size: isDesktopDialog ? 28 : 24,
                                  ),
                                ),
                                SizedBox(width: isDesktopDialog ? 18 : 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        device.name,
                                        style: AppTextStyles.cardTitle.copyWith(
                                          fontSize: isDesktopDialog ? 20 : 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        device.metadata,
                                        style: AppTextStyles.cardSubtitle
                                            .copyWith(
                                              fontSize: isDesktopDialog
                                                  ? 15
                                                  : 13,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 180),
                                  opacity: isSelected ? 1 : 0,
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
