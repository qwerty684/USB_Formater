import 'package:flutter/material.dart';

enum FileSystemFormat { fat, fat32, ntfs, udf, exfat, refs, ext2, ext3 }

extension FileSystemFormatX on FileSystemFormat {
  String get displayName {
    switch (this) {
      case FileSystemFormat.fat:
        return 'FAT';
      case FileSystemFormat.fat32:
        return 'FAT32';
      case FileSystemFormat.ntfs:
        return 'NTFS';
      case FileSystemFormat.udf:
        return 'UDF';
      case FileSystemFormat.exfat:
        return 'exFAT';
      case FileSystemFormat.refs:
        return 'ReFS';
      case FileSystemFormat.ext2:
        return 'ext2';
      case FileSystemFormat.ext3:
        return 'ext3';
    }
  }

  IconData get icon {
    switch (this) {
      case FileSystemFormat.fat:
        return Icons.storage_rounded;
      case FileSystemFormat.fat32:
        return Icons.sd_storage_rounded;
      case FileSystemFormat.ntfs:
        return Icons.laptop_windows_rounded;
      case FileSystemFormat.udf:
        return Icons.album_rounded;
      case FileSystemFormat.exfat:
        return Icons.flash_on_rounded;
      case FileSystemFormat.refs:
        return Icons.verified_rounded;
      case FileSystemFormat.ext2:
        return Icons.memory_rounded;
      case FileSystemFormat.ext3:
        return Icons.shield_outlined;
    }
  }
}
