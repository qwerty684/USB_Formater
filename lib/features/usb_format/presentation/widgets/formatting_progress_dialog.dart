import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_controller.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class FormattingProgressDialog extends ConsumerWidget {
  const FormattingProgressDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(usbFormatControllerProvider);
    final progress = state.formatProgress.clamp(0, 1).toDouble();
    final percentage = (progress * 100).round();

    return PopScope(
      canPop: false,
      child: AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.selectedFormatGradient,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 18),
            Text(l10n.formattingInProgress, style: AppTextStyles.dialogTitle),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: Text(
                state.formatStage == null
                    ? l10n.startingProcess
                    : l10n.formattingStageLabel(state.formatStage!),
                key: ValueKey(state.formatStage),
                textAlign: TextAlign.center,
                style: AppTextStyles.cardSubtitle.copyWith(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                color: AppColors.primaryPurple,
                backgroundColor: AppColors.primaryPurple.withValues(
                  alpha: 0.10,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '$percentage%',
              style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
