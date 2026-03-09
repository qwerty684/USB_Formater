class AppConstants {
  const AppConstants._();

  static const appName = 'USB Format';
  static const maxVolumeNameLength = 20;
  static final invalidVolumeNamePattern = RegExp(r'[\\/:*?"<>|]');
}
