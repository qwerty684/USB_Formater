import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class CreatorCreditChip extends StatelessWidget {
  const CreatorCreditChip({
    required this.onTap,
    this.isDesktop = false,
    super.key,
  });

  final VoidCallback onTap;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.creatorCreditTooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 14 : 12,
              vertical: isDesktop ? 10 : 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'by: EM.AV',
                  style: AppTextStyles.cardTitle.copyWith(
                    fontSize: isDesktop ? 13 : 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: isDesktop ? 8 : 6),
                Icon(
                  Icons.open_in_new_rounded,
                  size: isDesktop ? 16 : 14,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
