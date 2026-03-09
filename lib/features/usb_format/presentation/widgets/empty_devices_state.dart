import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class EmptyDevicesState extends StatelessWidget {
  const EmptyDevicesState({
    required this.onRetry,
    this.isDesktop = false,
    super.key,
  });

  final VoidCallback onRetry;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 28 : 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.66),
        borderRadius: BorderRadius.circular(isDesktop ? 28 : 22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Container(
            width: isDesktop ? 68 : 58,
            height: isDesktop ? 68 : 58,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(isDesktop ? 20 : 18),
            ),
            child: Icon(
              Icons.usb_off_rounded,
              color: AppColors.primaryPurple,
              size: isDesktop ? 34 : 24,
            ),
          ),
          SizedBox(height: isDesktop ? 18 : 16),
          Text(
            l10n.noDevicesFound,
            textAlign: TextAlign.center,
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: isDesktop ? 20 : 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.checkConnectionAndRetry,
            textAlign: TextAlign.center,
            style: AppTextStyles.cardSubtitle.copyWith(
              fontSize: isDesktop ? 15 : 13,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 16),
          FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}
