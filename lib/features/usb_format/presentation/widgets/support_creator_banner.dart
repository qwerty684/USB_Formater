import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class SupportCreatorBanner extends StatelessWidget {
  const SupportCreatorBanner({
    required this.onTap,
    this.isDesktop = false,
    super.key,
  });

  final VoidCallback onTap;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titleStyle = AppTextStyles.cardTitle.copyWith(
      color: Colors.white,
      fontSize: isDesktop ? 18 : 15,
    );
    final subtitleStyle = AppTextStyles.cardSubtitle.copyWith(
      color: Colors.white.withValues(alpha: 0.82),
      fontSize: isDesktop ? 13 : 12,
    );

    return Tooltip(
      message: l10n.supportBannerTooltip,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x38FFFFFF), Color(0x18FFFFFF)],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: isDesktop ? 24 : 18,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 18 : 16,
                vertical: isDesktop ? 14 : 12,
              ),
              child: Row(
                children: [
                  Container(
                    width: isDesktop ? 48 : 42,
                    height: isDesktop ? 48 : 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(isDesktop ? 16 : 14),
                    ),
                    child: Icon(
                      Icons.coffee_rounded,
                      color: Colors.white,
                      size: isDesktop ? 22 : 20,
                    ),
                  ),
                  SizedBox(width: isDesktop ? 14 : 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.supportBannerTitle, style: titleStyle),
                        const SizedBox(height: 2),
                        Text(l10n.supportBannerSubtitle, style: subtitleStyle),
                      ],
                    ),
                  ),
                  SizedBox(width: isDesktop ? 14 : 10),
                  Container(
                    width: isDesktop ? 40 : 36,
                    height: isDesktop ? 40 : 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.open_in_new_rounded,
                      size: 18,
                      color: Color(0xFF6A3DFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
