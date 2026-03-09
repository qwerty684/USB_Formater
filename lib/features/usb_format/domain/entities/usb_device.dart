class UsbDevice {
  const UsbDevice({
    required this.id,
    required this.name,
    required this.capacityGb,
    required this.currentFormat,
    required this.isConnected,
  });

  final String id;
  final String name;
  final int capacityGb;
  final String currentFormat;
  final bool isConnected;

  String get capacityLabel => '$capacityGb GB';
  String get metadata => '$capacityGb GB · $currentFormat';
}
