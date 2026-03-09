import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';

class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.headerGradient,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -60,
            left: -40,
            child: _GlowBubble(size: 190, color: Colors.white24),
          ),
          Positioned(
            top: 120,
            right: -55,
            child: _GlowBubble(
              size: 180,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          const Positioned(
            bottom: -90,
            left: -10,
            child: _GlowBubble(size: 220, color: Color(0x1AFFFFFF)),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _GlowBubble extends StatelessWidget {
  const _GlowBubble({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.8),
              blurRadius: 90,
              spreadRadius: 18,
            ),
          ],
        ),
      ),
    );
  }
}
