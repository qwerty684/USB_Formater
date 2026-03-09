import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveUtils {
  const ResponsiveUtils._();

  static bool isDesktopLayout(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobilePlatform =
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;

    return width >= 900 && !isMobilePlatform;
  }

  static double maxContentWidth(double width, {bool isDesktop = false}) {
    if (isDesktop) {
      if (width >= 1680) {
        return 1180;
      }
      if (width >= 1360) {
        return 1100;
      }
      return 980;
    }

    if (width >= 900) {
      return 560;
    }
    if (width >= 600) {
      return 520;
    }
    return width;
  }

  static double horizontalPadding(double width, {bool isDesktop = false}) {
    if (isDesktop) {
      if (width >= 1440) {
        return 56;
      }
      return 36;
    }

    if (width >= 600) {
      return 28;
    }
    if (width < 360) {
      return 16;
    }
    return 20;
  }

  static double formCardPadding(double width, {bool isDesktop = false}) {
    if (isDesktop) {
      return width >= 1200 ? 42 : 32;
    }

    if (width < 360) {
      return 20;
    }
    return 24;
  }

  static double formatGridAspectRatio(double width, {bool isDesktop = false}) {
    if (isDesktop) {
      if (width >= 560) {
        return 0.94;
      }
      return 1.02;
    }

    if (width < 340) {
      return 0.82;
    }
    if (width < 390) {
      return 0.92;
    }
    return 1.02;
  }

  static int formatGridCrossAxisCount(double width, {bool isDesktop = false}) {
    if (isDesktop) {
      return width >= 560 ? 3 : 2;
    }

    return 2;
  }

  static bool isCompactHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height < 760;
  }
}
