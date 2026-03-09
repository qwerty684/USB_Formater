import 'dart:ui';

enum AppLanguage { serbian, english, german }

extension AppLanguageX on AppLanguage {
  Locale get locale {
    switch (this) {
      case AppLanguage.serbian:
        return const Locale('sr');
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.german:
        return const Locale('de');
    }
  }

  String get shortLabel {
    switch (this) {
      case AppLanguage.serbian:
        return 'SR';
      case AppLanguage.english:
        return 'EN';
      case AppLanguage.german:
        return 'DE';
    }
  }

  static AppLanguage fromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return AppLanguage.english;
      case 'de':
        return AppLanguage.german;
      case 'sr':
      default:
        return AppLanguage.serbian;
    }
  }
}
