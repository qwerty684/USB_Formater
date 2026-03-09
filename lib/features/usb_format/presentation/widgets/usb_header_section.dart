import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class UsbHeaderSection extends StatelessWidget {
  const UsbHeaderSection({
    required this.compact,
    this.isDesktop = false,
    this.topAction,
    super.key,
  });

  final bool compact;
  final bool isDesktop;
  final Widget? topAction;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final iconBoxSize = isDesktop ? 120.0 : (compact ? 80.0 : 92.0);
    final iconSize = isDesktop ? 56.0 : 42.0;
    final titleSize = isDesktop ? 58.0 : (compact ? 34.0 : 40.0);
    final subtitleSize = isDesktop ? 17.0 : (compact ? 14.0 : 15.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0, 1).toDouble(),
          child: Transform.scale(scale: value, child: child),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          12,
          isDesktop ? 20 : (compact ? 14 : 22),
          12,
          isDesktop ? 18 : (compact ? 34 : 44),
        ),
        child: Stack(
          children: [
            if (topAction != null)
              Positioned(top: 0, right: 0, child: topAction!),
            Padding(
              padding: EdgeInsets.only(top: topAction != null ? 8 : 0),
              child: Column(
                children: [
                  Container(
                    width: iconBoxSize,
                    height: iconBoxSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isDesktop ? 34 : 26),
                      color: Colors.white.withValues(alpha: 0.18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.10),
                          blurRadius: isDesktop ? 34 : 22,
                          spreadRadius: isDesktop ? 6 : 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.usb_rounded,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 22 : 20),
                  Text(
                    l10n.heroTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heroTitle.copyWith(
                      fontSize: titleSize,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 12 : 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 560 : 320,
                    ),
                    child: Text(
                      l10n.heroSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heroSubtitle.copyWith(
                        fontSize: subtitleSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
