import 'package:flutter/material.dart';

enum FileSystemFormat { fat32, ntfs, exfat, ext4 }

extension FileSystemFormatX on FileSystemFormat {
  String get displayName {
    switch (this) {
      case FileSystemFormat.fat32:
        return 'FAT32';
      case FileSystemFormat.ntfs:
        return 'NTFS';
      case FileSystemFormat.exfat:
        return 'exFAT';
      case FileSystemFormat.ext4:
        return 'ext4';
    }
  }

  IconData get icon {
    switch (this) {
      case FileSystemFormat.fat32:
        return Icons.sd_storage_rounded;
      case FileSystemFormat.ntfs:
        return Icons.laptop_windows_rounded;
      case FileSystemFormat.exfat:
        return Icons.flash_on_rounded;
      case FileSystemFormat.ext4:
        return Icons.shield_outlined;
    }
  }
}
