import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class QuickFormatTile extends StatelessWidget {
  const QuickFormatTile({
    required this.value,
    required this.onChanged,
    this.isDesktop = false,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 18 : 16,
        vertical: isDesktop ? 18 : 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.blueTint.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
        border: Border.all(color: AppColors.infoBorder),
      ),
      child: Row(
        children: [
          Container(
            width: isDesktop ? 48 : 42,
            height: isDesktop ? 48 : 42,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(isDesktop ? 16 : 14),
            ),
            child: Icon(
              Icons.flash_on_rounded,
              color: AppColors.primaryPurple,
              size: isDesktop ? 24 : 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.quickFormatTitle,
                  style: AppTextStyles.cardTitle.copyWith(
                    fontSize: isDesktop ? 17 : 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.quickFormatSubtitle,
                  style: AppTextStyles.cardSubtitle.copyWith(
                    fontSize: isDesktop ? 14 : 13,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
