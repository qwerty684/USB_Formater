import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';

class PrimaryGradientButton extends StatelessWidget {
  const PrimaryGradientButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onPressed,
    this.isLoading = false,
    this.isDesktop = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final bool isLoading;
  final VoidCallback onPressed;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(isDesktop ? 24 : 20);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : 0.58,
      child: IgnorePointer(
        ignoring: !enabled,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: enabled
                ? const LinearGradient(colors: AppColors.primaryActionGradient)
                : const LinearGradient(
                    colors: [AppColors.disabled, AppColors.disabled],
                  ),
            borderRadius: borderRadius,
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.orange.withValues(alpha: 0.28),
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                    ),
                  ]
                : const [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: borderRadius,
              child: SizedBox(
                height: isDesktop ? 66 : 58,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: isLoading
                        ? const SizedBox(
                            key: ValueKey('loading'),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            key: const ValueKey('label'),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon,
                                color: Colors.white,
                                size: isDesktop ? 24 : 20,
                              ),
                              SizedBox(width: isDesktop ? 12 : 10),
                              Text(
                                label,
                                style: AppTextStyles.buttonLabel.copyWith(
                                  fontSize: isDesktop ? 18 : 17,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
