import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:usb_formater/core/constants/app_constants.dart';
import 'package:usb_formater/core/utils/volume_name_validator.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/formatting_progress.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_feedback.dart';
import 'package:usb_formater/l10n/app_language.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('sr'),
    Locale('en'),
    Locale('de'),
  ];

  static const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(localizations != null, 'AppLocalizations is missing in context.');
    return localizations!;
  }

  AppLanguage get selectedLanguage => AppLanguageX.fromLocale(locale);

  bool get _isEnglish => locale.languageCode == 'en';
  bool get _isGerman => locale.languageCode == 'de';

  String get appTitle => AppConstants.appName;
  String get heroTitle => AppConstants.appName;

  String get heroSubtitle {
    if (_isEnglish) {
      return 'Format USB devices quickly and easily';
    }
    if (_isGerman) {
      return 'USB-Gerate schnell und einfach formatieren';
    }
    return 'Formatirajte USB uredaje brzo i lako';
  }

  String get supportBannerTitle {
    if (_isGerman) {
      return 'Buy me a coffee';
    }
    return 'Buy me a coffee';
  }

  String get supportBannerSubtitle {
    if (_isEnglish) {
      return 'Support future updates';
    }
    if (_isGerman) {
      return 'Unterstutze die weitere Entwicklung';
    }
    return 'Podrzi dalji razvoj aplikacije';
  }

  String get supportBannerTooltip {
    if (_isEnglish) {
      return 'Open support page';
    }
    if (_isGerman) {
      return 'Support-Seite offnen';
    }
    return 'Otvori stranicu za podrsku';
  }

  String get creatorCreditTooltip {
    if (_isEnglish) {
      return 'Open creator profile';
    }
    if (_isGerman) {
      return 'Creator-Profil offnen';
    }
    return 'Otvori profil autora';
  }

  String get languageSelectorLabel {
    if (_isEnglish) {
      return 'Language';
    }
    if (_isGerman) {
      return 'Sprache';
    }
    return 'Jezik';
  }

  String languageTooltip(AppLanguage language) {
    switch (language) {
      case AppLanguage.serbian:
        return _isGerman ? 'Serbisch' : (_isEnglish ? 'Serbian' : 'Srpski');
      case AppLanguage.english:
        return _isGerman ? 'Englisch' : (_isEnglish ? 'English' : 'Engleski');
      case AppLanguage.german:
        return _isGerman ? 'Deutsch' : (_isEnglish ? 'German' : 'Nemacki');
    }
  }

  String get chooseDevice {
    if (_isEnglish) {
      return 'Select device';
    }
    if (_isGerman) {
      return 'Gerat auswahlen';
    }
    return 'Izaberite uredaj';
  }

  String get refreshDevices {
    if (_isEnglish) {
      return 'Refresh devices';
    }
    if (_isGerman) {
      return 'Gerate aktualisieren';
    }
    return 'Osvezi uredaje';
  }

  String get searchingDevices {
    if (_isEnglish) {
      return 'Searching for devices...';
    }
    if (_isGerman) {
      return 'Gerate werden gesucht...';
    }
    return 'Trazenje uredaja...';
  }

  String get pleaseWait {
    if (_isEnglish) {
      return 'Please wait';
    }
    if (_isGerman) {
      return 'Bitte warten';
    }
    return 'Molimo sacekajte';
  }

  String get noSelectedDevice {
    if (_isEnglish) {
      return 'No device selected';
    }
    if (_isGerman) {
      return 'Kein Gerat ausgewahlt';
    }
    return 'Nema izabranog uredaja';
  }

  String get tapToChooseUsbDevice {
    if (_isEnglish) {
      return 'Tap to choose a USB device';
    }
    if (_isGerman) {
      return 'Tippen Sie, um ein USB-Gerat auszuwahlen';
    }
    return 'Dodirnite za izbor USB uredaja';
  }

  String get availableUsbDevices {
    if (_isEnglish) {
      return 'Available USB devices';
    }
    if (_isGerman) {
      return 'Verfugbare USB-Gerate';
    }
    return 'Dostupni USB uredaji';
  }

  String get chooseDeviceToFormat {
    if (_isEnglish) {
      return 'Choose the device you want to format.';
    }
    if (_isGerman) {
      return 'Wahlen Sie das Gerat aus, das Sie formatieren mochten.';
    }
    return 'Izaberite uredaj koji zelite da formatirate.';
  }

  String get noDevicesFound {
    if (_isEnglish) {
      return 'No USB devices found';
    }
    if (_isGerman) {
      return 'Keine USB-Gerate gefunden';
    }
    return 'Nema pronadenih USB uredaja';
  }

  String get noDevicesFoundShort {
    if (_isEnglish) {
      return 'No USB devices found.';
    }
    if (_isGerman) {
      return 'Keine USB-Gerate gefunden.';
    }
    return 'Nema pronadenih USB uredaja.';
  }

  String get checkConnectionAndRetry {
    if (_isEnglish) {
      return 'Check the connection and try again.';
    }
    if (_isGerman) {
      return 'Prufen Sie die Verbindung und versuchen Sie es erneut.';
    }
    return 'Proverite vezu uredaja i pokusajte ponovo.';
  }

  String get retry {
    if (_isEnglish) {
      return 'Try again';
    }
    if (_isGerman) {
      return 'Erneut versuchen';
    }
    return 'Pokusaj ponovo';
  }

  String get chooseFormat {
    if (_isEnglish) {
      return 'Select format';
    }
    if (_isGerman) {
      return 'Format auswahlen';
    }
    return 'Izaberite format';
  }

  String get volumeNameOptional {
    if (_isEnglish) {
      return 'Volume name (optional)';
    }
    if (_isGerman) {
      return 'Volume-Name (optional)';
    }
    return 'Naziv volumena (opciono)';
  }

  String get volumeNameHint {
    if (_isEnglish) {
      return 'For example: MY_USB';
    }
    if (_isGerman) {
      return 'Zum Beispiel: MY_USB';
    }
    return 'Npr: MY_USB';
  }

  String get quickFormatTitle {
    if (_isEnglish) {
      return 'Quick format';
    }
    if (_isGerman) {
      return 'Schnellformatierung';
    }
    return 'Brzo formatiranje';
  }

  String get quickFormatSubtitle {
    if (_isEnglish) {
      return 'Faster process';
    }
    if (_isGerman) {
      return 'Schnellerer Vorgang';
    }
    return 'Brzi proces';
  }

  String get warningTitle {
    if (_isEnglish) {
      return 'Warning! ';
    }
    if (_isGerman) {
      return 'Achtung! ';
    }
    return 'Paznja! ';
  }

  String get warningMessage {
    if (_isEnglish) {
      return 'All data will be erased. Create a backup first!';
    }
    if (_isGerman) {
      return 'Alle Daten werden geloscht. Erstellen Sie zuerst ein Backup!';
    }
    return 'Svi podaci ce biti obrisani. Napravite backup!';
  }

  String get startFormatting {
    if (_isEnglish) {
      return 'Start formatting';
    }
    if (_isGerman) {
      return 'Formatierung starten';
    }
    return 'Pokreni formatiranje';
  }

  String get confirmationTitle {
    if (_isEnglish) {
      return 'Confirm formatting';
    }
    if (_isGerman) {
      return 'Formatierung bestatigen';
    }
    return 'Potvrdite formatiranje';
  }

  String get confirmationMessage {
    if (_isEnglish) {
      return 'Are you sure you want to format this device? All data will be permanently erased.';
    }
    if (_isGerman) {
      return 'Mochten Sie dieses Gerat wirklich formatieren? Alle Daten werden dauerhaft geloscht.';
    }
    return 'Da li ste sigurni da zelite da formatirate ovaj uredaj? Svi podaci ce biti trajno obrisani.';
  }

  String get deviceLabel {
    if (_isEnglish) {
      return 'Device';
    }
    if (_isGerman) {
      return 'Gerat';
    }
    return 'Uredaj';
  }

  String get formatLabel {
    if (_isEnglish) {
      return 'Format';
    }
    if (_isGerman) {
      return 'Format';
    }
    return 'Format';
  }

  String get volumeLabel {
    if (_isEnglish) {
      return 'Volume';
    }
    if (_isGerman) {
      return 'Volume';
    }
    return 'Volumen';
  }

  String get defaultVolumeName {
    if (_isEnglish) {
      return 'Default name';
    }
    if (_isGerman) {
      return 'Standardname';
    }
    return 'Podrazumevani naziv';
  }

  String get quickFormatLabel {
    if (_isEnglish) {
      return 'Quick format';
    }
    if (_isGerman) {
      return 'Schnellformatierung';
    }
    return 'Brzo formatiranje';
  }

  String get enabledLabel {
    if (_isEnglish) {
      return 'Enabled';
    }
    if (_isGerman) {
      return 'Aktiviert';
    }
    return 'Ukljuceno';
  }

  String get disabledLabel {
    if (_isEnglish) {
      return 'Disabled';
    }
    if (_isGerman) {
      return 'Deaktiviert';
    }
    return 'Iskljuceno';
  }

  String get cancel {
    if (_isEnglish) {
      return 'Cancel';
    }
    if (_isGerman) {
      return 'Abbrechen';
    }
    return 'Otkazi';
  }

  String get formatAction {
    if (_isEnglish) {
      return 'Format';
    }
    if (_isGerman) {
      return 'Formatieren';
    }
    return 'Formatiraj';
  }

  String get formattingInProgress {
    if (_isEnglish) {
      return 'Formatting in progress';
    }
    if (_isGerman) {
      return 'Formatierung lauft';
    }
    return 'Formatiranje u toku';
  }

  String get startingProcess {
    if (_isEnglish) {
      return 'Starting process...';
    }
    if (_isGerman) {
      return 'Vorgang wird gestartet...';
    }
    return 'Pokretanje procesa...';
  }

  String get formattingSuccessTitle {
    if (_isEnglish) {
      return 'Formatting completed successfully';
    }
    if (_isGerman) {
      return 'Formatierung erfolgreich abgeschlossen';
    }
    return 'Formatiranje uspesno zavrseno';
  }

  String formattingSuccessMessage(String deviceName, String formatName) {
    if (_isEnglish) {
      return '$deviceName was successfully formatted to $formatName.';
    }
    if (_isGerman) {
      return '$deviceName wurde erfolgreich in $formatName formatiert.';
    }
    return '$deviceName je uspesno formatiran u $formatName sistem.';
  }

  String get close {
    if (_isEnglish) {
      return 'Close';
    }
    if (_isGerman) {
      return 'SchlieBen';
    }
    return 'Zatvori';
  }

  String get deviceReadyForUse {
    if (_isEnglish) {
      return 'The device is ready to use.';
    }
    if (_isGerman) {
      return 'Das Gerat ist einsatzbereit.';
    }
    return 'Uredaj je spreman za koriscenje.';
  }

  String get listRefreshed {
    if (_isEnglish) {
      return 'Device list refreshed.';
    }
    if (_isGerman) {
      return 'Gerateliste wurde aktualisiert.';
    }
    return 'Lista uredaja je osvezena.';
  }

  String deviceSelected(String name) {
    if (_isEnglish) {
      return '$name was selected.';
    }
    if (_isGerman) {
      return '$name wurde ausgewahlt.';
    }
    return '$name je izabran.';
  }

  String get couldNotOpenSupportLink {
    if (_isEnglish) {
      return 'Unable to open the support link.';
    }
    if (_isGerman) {
      return 'Der Support-Link konnte nicht geoffnet werden.';
    }
    return 'Nije moguce otvoriti link za podrsku.';
  }

  String get couldNotOpenCreatorLink {
    if (_isEnglish) {
      return 'Unable to open the creator profile.';
    }
    if (_isGerman) {
      return 'Das Creator-Profil konnte nicht geoffnet werden.';
    }
    return 'Nije moguce otvoriti profil autora.';
  }

  String get realDeviceDetectionUnsupported {
    if (_isEnglish) {
      return 'Real connected device detection is currently supported only in the macOS desktop app.';
    }
    if (_isGerman) {
      return 'Die Erkennung real verbundener Gerate wird derzeit nur in der macOS-Desktop-App unterstutzt.';
    }
    return 'Prikaz stvarno povezanih USB uredaja podrzan je samo u macOS desktop aplikaciji.';
  }

  String get couldNotLoadUsbDevices {
    if (_isEnglish) {
      return 'Unable to load USB devices.';
    }
    if (_isGerman) {
      return 'USB-Gerate konnten nicht geladen werden.';
    }
    return 'Nije moguce ucitati USB uredaje.';
  }

  String get selectDeviceBeforeFormatting {
    if (_isEnglish) {
      return 'Select a USB device before starting formatting.';
    }
    if (_isGerman) {
      return 'Wahlen Sie vor dem Start der Formatierung ein USB-Gerat aus.';
    }
    return 'Izaberite USB uredaj pre pokretanja formatiranja.';
  }

  String get formattingFailed {
    if (_isEnglish) {
      return 'An error occurred during formatting.';
    }
    if (_isGerman) {
      return 'Wahrend der Formatierung ist ein Fehler aufgetreten.';
    }
    return 'Doslo je do greske tokom formatiranja.';
  }

  String volumeNameValidationMessage(VolumeNameValidationError error) {
    switch (error) {
      case VolumeNameValidationError.tooLong:
        if (_isEnglish) {
          return 'Volume name can contain up to 20 characters.';
        }
        if (_isGerman) {
          return 'Der Volume-Name darf maximal 20 Zeichen enthalten.';
        }
        return 'Naziv volumena moze imati najvise 20 karaktera.';
      case VolumeNameValidationError.invalidCharacters:
        if (_isEnglish) {
          return 'Volume name cannot contain \\\\ / : * ? " < > |.';
        }
        if (_isGerman) {
          return 'Der Volume-Name darf \\\\ / : * ? " < > | nicht enthalten.';
        }
        return 'Naziv volumena ne sme sadrzati \\\\ / : * ? " < > |.';
    }
  }

  String feedbackMessage(
    UsbFormatFeedback feedback, {
    VolumeNameValidationError? volumeNameError,
  }) {
    switch (feedback) {
      case UsbFormatFeedback.deviceDiscoveryUnsupported:
        return realDeviceDetectionUnsupported;
      case UsbFormatFeedback.devicesLoadFailed:
        return couldNotLoadUsbDevices;
      case UsbFormatFeedback.deviceRequired:
        return selectDeviceBeforeFormatting;
      case UsbFormatFeedback.volumeNameInvalid:
        return volumeNameValidationMessage(
          volumeNameError ?? VolumeNameValidationError.invalidCharacters,
        );
      case UsbFormatFeedback.formattingFailed:
        return formattingFailed;
    }
  }

  String formattingStageLabel(FormattingStage stage) {
    switch (stage) {
      case FormattingStage.starting:
        if (_isEnglish) {
          return 'Starting formatting...';
        }
        if (_isGerman) {
          return 'Formatierung wird gestartet...';
        }
        return 'Pokretanje formatiranja...';
      case FormattingStage.preparingDevice:
        if (_isEnglish) {
          return 'Preparing device...';
        }
        if (_isGerman) {
          return 'Gerat wird vorbereitet...';
        }
        return 'Priprema uredaja...';
      case FormattingStage.erasingPartitions:
        if (_isEnglish) {
          return 'Erasing partitions...';
        }
        if (_isGerman) {
          return 'Partitionen werden geloscht...';
        }
        return 'Brisanje particija...';
      case FormattingStage.creatingFileSystem:
        if (_isEnglish) {
          return 'Creating file system...';
        }
        if (_isGerman) {
          return 'Dateisystem wird erstellt...';
        }
        return 'Kreiranje fajl sistema...';
      case FormattingStage.finishingProcess:
        if (_isEnglish) {
          return 'Finishing process...';
        }
        if (_isGerman) {
          return 'Vorgang wird abgeschlossen...';
        }
        return 'Zavrsavanje procesa...';
      case FormattingStage.completed:
        if (_isEnglish) {
          return 'Formatting completed successfully';
        }
        if (_isGerman) {
          return 'Formatierung erfolgreich abgeschlossen';
        }
        return 'Formatiranje uspesno zavrseno';
    }
  }

  String formatDescription(FileSystemFormat format) {
    switch (format) {
      case FileSystemFormat.fat:
        if (_isEnglish) {
          return 'For legacy devices';
        }
        if (_isGerman) {
          return 'Fur alte Gerate';
        }
        return 'Za starije uredaje';
      case FileSystemFormat.fat32:
        if (_isEnglish) {
          return 'Compatible with most devices';
        }
        if (_isGerman) {
          return 'Kompatibel mit den meisten Geraten';
        }
        return 'Kompatibilan sa vecinom uredaja';
      case FileSystemFormat.ntfs:
        if (_isEnglish) {
          return 'For Windows systems';
        }
        if (_isGerman) {
          return 'Fur Windows-Systeme';
        }
        return 'Za Windows sisteme';
      case FileSystemFormat.udf:
        if (_isEnglish) {
          return 'For discs and archives';
        }
        if (_isGerman) {
          return 'Fur Medien und Archive';
        }
        return 'Za diskove i arhive';
      case FileSystemFormat.exfat:
        if (_isEnglish) {
          return 'For large files';
        }
        if (_isGerman) {
          return 'Fur groBe Dateien';
        }
        return 'Za velike fajlove';
      case FileSystemFormat.refs:
        if (_isEnglish) {
          return 'For resilient storage';
        }
        if (_isGerman) {
          return 'Fur ausfallsicheren Speicher';
        }
        return 'Za otpornije skladistenje';
      case FileSystemFormat.ext2:
        if (_isEnglish) {
          return 'Light Linux format';
        }
        if (_isGerman) {
          return 'Leichtes Linux-Format';
        }
        return 'Laksi Linux format';
      case FileSystemFormat.ext3:
        if (_isEnglish) {
          return 'Linux with journaling';
        }
        if (_isGerman) {
          return 'Linux mit Journaling';
        }
        return 'Linux sa journaling-om';
    }
  }

  String formatCompatibilityNote(FileSystemFormat format) {
    switch (format) {
      case FileSystemFormat.fat:
        if (_isEnglish) {
          return 'Maximum legacy support';
        }
        if (_isGerman) {
          return 'Maximale Legacy-Unterstutzung';
        }
        return 'Najveca podrska za starije uredaje';
      case FileSystemFormat.fat32:
        if (_isEnglish) {
          return 'Wide device support';
        }
        if (_isGerman) {
          return 'Breite Gerateunterstutzung';
        }
        return 'Siroka podrska uredaja';
      case FileSystemFormat.ntfs:
        if (_isEnglish) {
          return 'Best for Windows';
        }
        if (_isGerman) {
          return 'Am besten fur Windows';
        }
        return 'Najbolje radi na Windows-u';
      case FileSystemFormat.udf:
        if (_isEnglish) {
          return 'Great for optical media';
        }
        if (_isGerman) {
          return 'Ideal fur optische Medien';
        }
        return 'Odlican za opticke medije';
      case FileSystemFormat.exfat:
        if (_isEnglish) {
          return 'Ideal for 4K and large archives';
        }
        if (_isGerman) {
          return 'Ideal fur 4K und groBe Archive';
        }
        return 'Idealan za 4K i velike arhive';
      case FileSystemFormat.refs:
        if (_isEnglish) {
          return 'Integrity-focused Windows format';
        }
        if (_isGerman) {
          return 'Windows-Format mit Fokus auf Integritat';
        }
        return 'Windows format fokusiran na integritet';
      case FileSystemFormat.ext2:
        if (_isEnglish) {
          return 'Low-overhead Linux option';
        }
        if (_isGerman) {
          return 'Linux-Option mit wenig Overhead';
        }
        return 'Linux opcija sa malim overhead-om';
      case FileSystemFormat.ext3:
        if (_isEnglish) {
          return 'Stable Linux journaling';
        }
        if (_isGerman) {
          return 'Stabiles Linux-Journaling';
        }
        return 'Stabilan Linux journaling';
    }
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
