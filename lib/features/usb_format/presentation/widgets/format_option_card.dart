import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class FormatOptionCard extends StatelessWidget {
  const FormatOptionCard({
    required this.format,
    required this.isSelected,
    required this.onTap,
    this.isDesktop = false,
    super.key,
  });

  final FileSystemFormat format;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cardPadding = isDesktop ? 24.0 : 16.0;
    final iconBoxSize = isDesktop ? 64.0 : 44.0;
    final iconRadius = isDesktop ? 18.0 : 14.0;

    return AnimatedScale(
      scale: isSelected ? 1 : 0.98,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(cardPadding),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColors.selectedFormatGradient,
                    )
                  : null,
              color: isSelected ? null : AppColors.unselectedTileBackground,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColors.divider.withValues(alpha: 0.7),
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.orange.withValues(alpha: 0.28)
                      : Colors.black.withValues(alpha: 0.04),
                  blurRadius: isSelected ? 24 : 14,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: iconBoxSize,
                      height: iconBoxSize,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.24)
                            : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(iconRadius),
                      ),
                      child: Icon(
                        format.icon,
                        size: isDesktop ? 30 : 24,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      format.displayName,
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: isDesktop ? 20 : 16,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.formatDescription(format),
                      style: AppTextStyles.cardSubtitle.copyWith(
                        fontSize: isDesktop ? 15 : 13,
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.92)
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: isDesktop ? 28 : 22,
                      height: isDesktop ? 28 : 22,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: isDesktop ? 18 : 14,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
