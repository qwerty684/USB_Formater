import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/l10n/app_language.dart';
import 'package:usb_formater/l10n/app_locale_controller.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({this.isDesktop = false, super.key});

  final bool isDesktop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final selectedLanguage = AppLanguageX.fromLocale(locale);
    final borderRadius = BorderRadius.circular(isDesktop ? 22 : 18);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isDesktop ? 0.18 : 0.14),
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDesktop ? 0.10 : 0.08),
            blurRadius: isDesktop ? 20 : 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 6 : 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 12 : 10),
              child: Icon(
                Icons.language_rounded,
                size: isDesktop ? 18 : 16,
                color: Colors.white,
              ),
            ),
            for (final language in AppLanguage.values)
              _LanguageOption(
                language: language,
                isDesktop: isDesktop,
                isSelected: language == selectedLanguage,
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(appLocaleProvider.notifier).selectLanguage(language);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.language,
    required this.isSelected,
    required this.onTap,
    required this.isDesktop,
  });

  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.languageTooltip(language),
      waitDuration: const Duration(milliseconds: 250),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 12 : 10,
              vertical: isDesktop ? 10 : 8,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              language.shortLabel,
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: isDesktop ? 13 : 12,
                color: isSelected ? const Color(0xFF5B31E9) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
