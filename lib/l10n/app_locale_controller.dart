import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/l10n/app_language.dart';

final appLocaleProvider = StateNotifierProvider<AppLocaleController, Locale>(
  (ref) => AppLocaleController(),
);

class AppLocaleController extends StateNotifier<Locale> {
  AppLocaleController() : super(AppLanguage.serbian.locale);

  void selectLanguage(AppLanguage language) {
    state = language.locale;
  }
}
