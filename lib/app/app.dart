import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/app/theme/app_theme.dart';
import 'package:usb_formater/features/usb_format/presentation/pages/usb_format_page.dart';
import 'package:usb_formater/l10n/app_locale_controller.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class UsbFormatApp extends ConsumerWidget {
  const UsbFormatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);

    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const UsbFormatPage(),
    );
  }
}
