import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';

class UsbDeviceCard extends StatelessWidget {
  const UsbDeviceCard({
    required this.device,
    this.isDesktop = false,
    super.key,
  });

  final UsbDevice device;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final iconSize = isDesktop ? 84.0 : 42.0;
    final iconRadius = isDesktop ? 24.0 : 14.0;
    final padding = isDesktop ? 28.0 : 16.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.infoBackground.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(isDesktop ? 28 : 20),
        border: Border.all(color: AppColors.infoBorder),
      ),
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(iconRadius),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: AppColors.primaryPurple,
              size: isDesktop ? 42 : 24,
            ),
          ),
          SizedBox(width: isDesktop ? 24 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.name,
                  style: AppTextStyles.cardTitle.copyWith(
                    fontSize: isDesktop ? 24 : 16,
                  ),
                ),
                SizedBox(height: isDesktop ? 12 : 8),
                Wrap(
                  spacing: isDesktop ? 10 : 8,
                  runSpacing: isDesktop ? 10 : 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 16 : 10,
                        vertical: isDesktop ? 8 : 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        device.currentFormat,
                        style: AppTextStyles.cardSubtitle.copyWith(
                          fontSize: isDesktop ? 16 : 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '•',
                      style: AppTextStyles.cardSubtitle.copyWith(
                        fontSize: isDesktop ? 16 : 13,
                      ),
                    ),
                    Text(
                      device.capacityLabel,
                      style: AppTextStyles.cardSubtitle.copyWith(
                        fontSize: isDesktop ? 16 : 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
