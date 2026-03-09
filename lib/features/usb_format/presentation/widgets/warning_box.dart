import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class WarningBox extends StatelessWidget {
  const WarningBox({this.isDesktop = false, super.key});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: EdgeInsets.all(isDesktop ? 18 : 16),
      decoration: BoxDecoration(
        color: AppColors.warningBackground,
        borderRadius: BorderRadius.circular(isDesktop ? 22 : 20),
        border: Border.all(color: AppColors.warningBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.warning_amber_rounded,
              color: AppColors.warningBorder,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: l10n.warningTitle,
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF8A4B00),
                ),
                children: [
                  TextSpan(
                    text: l10n.warningMessage,
                    style: AppTextStyles.cardSubtitle.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF8A4B00),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
