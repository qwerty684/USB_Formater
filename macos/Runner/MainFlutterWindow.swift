import Cocoa
import DiskArbitration
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  private var usbDeviceChannel: FlutterMethodChannel?

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    let usbDeviceChannel = FlutterMethodChannel(
      name: "usb_formater/device_scanner",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )
    self.usbDeviceChannel = usbDeviceChannel

    usbDeviceChannel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else {
        result(
          FlutterError(
            code: "window_unavailable",
            message: "Glavni prozor nije dostupan.",
            details: nil
          )
        )
        return
      }

      switch call.method {
      case "getConnectedDevices":
        result(self.fetchConnectedDevices())
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }

  private func fetchConnectedDevices() -> [[String: Any]] {
    let resourceKeys: [URLResourceKey] = [
      .volumeNameKey,
      .volumeLocalizedFormatDescriptionKey,
      .volumeIsBrowsableKey,
      .volumeIsLocalKey,
      .volumeIsInternalKey,
    ]

    guard let session = DASessionCreate(kCFAllocatorDefault) else {
      return []
    }

    let volumes =
      FileManager.default.mountedVolumeURLs(
        includingResourceValuesForKeys: resourceKeys,
        options: [.skipHiddenVolumes]
      ) ?? []

    let devices = volumes.compactMap { volumeURL -> [String: Any]? in
      guard volumeURL.path != "/" else {
        return nil
      }

      guard
        let values = try? volumeURL.resourceValues(forKeys: Set(resourceKeys)),
        values.volumeIsBrowsable == true,
        values.volumeIsLocal == true,
        values.volumeIsInternal != true
      else {
        return nil
      }

      guard
        let disk = DADiskCreateFromVolumePath(
          kCFAllocatorDefault,
          session,
          volumeURL as CFURL
        ),
        let description = DADiskCopyDescription(disk) as NSDictionary?
          as? [String: Any]
      else {
        return nil
      }

      let isInternal =
        (description[kDADiskDescriptionDeviceInternalKey as String] as? NSNumber)?
        .boolValue ?? false
      if isInternal {
        return nil
      }

      let protocolName =
        (description[kDADiskDescriptionDeviceProtocolKey as String] as? String) ?? ""
      if shouldExcludeDevice(protocolName: protocolName) {
        return nil
      }

      let mediaSize =
        (description[kDADiskDescriptionMediaSizeKey as String] as? NSNumber)?
        .int64Value ?? 0
      let capacityGb = max(
        1,
        Int((Double(mediaSize) / 1_000_000_000).rounded())
      )

      return [
        "id": volumeURL.path,
        "name": resolveDeviceName(description: description, volumeURL: volumeURL),
        "capacityGb": capacityGb,
        "currentFormat": normalizedFormatLabel(
          volumeKind: description[kDADiskDescriptionVolumeKindKey as String] as? String,
          localizedFormat: values.volumeLocalizedFormatDescription
        ),
        "isConnected": true,
      ]
    }

    return devices.sorted {
      let leftName = ($0["name"] as? String) ?? ""
      let rightName = ($1["name"] as? String) ?? ""
      return leftName.localizedCaseInsensitiveCompare(rightName) == .orderedAscending
    }
  }

  private func resolveDeviceName(
    description: [String: Any],
    volumeURL: URL
  ) -> String {
    if
      let volumeName = description[kDADiskDescriptionVolumeNameKey as String] as? String,
      !volumeName.isEmpty
    {
      return volumeName
    }

    if
      let mediaName = description[kDADiskDescriptionMediaNameKey as String] as? String,
      !mediaName.isEmpty
    {
      return mediaName
    }

    return volumeURL.lastPathComponent
  }

  private func normalizedFormatLabel(
    volumeKind: String?,
    localizedFormat: String?
  ) -> String {
    let localizedUpper = localizedFormat?.uppercased() ?? ""

    if localizedUpper.contains("EXFAT") {
      return "exFAT"
    }
    if localizedUpper.contains("NTFS") {
      return "NTFS"
    }
    if localizedUpper.contains("FAT32") || localizedUpper.contains("MS-DOS") {
      return "FAT32"
    }
    if localizedUpper.contains("APFS") {
      return "APFS"
    }
    if localizedUpper.contains("HFS") {
      return "HFS+"
    }

    switch volumeKind?.lowercased() {
    case "exfat":
      return "exFAT"
    case "ntfs":
      return "NTFS"
    case "msdos":
      return "FAT32"
    case "apfs":
      return "APFS"
    case "hfs", "hfs+", "hfsplus":
      return "HFS+"
    case "ext4":
      return "ext4"
    case let .some(kind) where !kind.isEmpty:
      return kind.uppercased()
    default:
      return localizedFormat ?? "Nepoznat"
    }
  }

  private func shouldExcludeDevice(protocolName: String) -> Bool {
    let lowercasedProtocol = protocolName.lowercased()

    if lowercasedProtocol.contains("disk image") {
      return true
    }
    if lowercasedProtocol.contains("virtual") {
      return true
    }
    if lowercasedProtocol.contains("network") {
      return true
    }

    return false
  }
}
