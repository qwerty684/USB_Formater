import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usb_formater/app/theme/app_colors.dart';
import 'package:usb_formater/app/theme/app_text_styles.dart';
import 'package:usb_formater/core/utils/responsive_utils.dart';
import 'package:usb_formater/core/utils/volume_name_validator.dart';
import 'package:usb_formater/core/widgets/app_gradient_background.dart';
import 'package:usb_formater/core/widgets/language_selector.dart';
import 'package:usb_formater/features/usb_format/domain/entities/file_system_format.dart';
import 'package:usb_formater/features/usb_format/domain/entities/usb_device.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_controller.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_feedback.dart';
import 'package:usb_formater/features/usb_format/presentation/controllers/usb_format_state.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/confirmation_dialog.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/creator_credit_chip.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/empty_devices_state.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/format_option_card.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/formatting_progress_dialog.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/primary_gradient_button.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/quick_format_tile.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/section_title.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/support_creator_banner.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/usb_device_card.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/usb_device_dropdown.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/usb_device_picker_sheet.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/usb_header_section.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/volume_name_field.dart';
import 'package:usb_formater/features/usb_format/presentation/widgets/warning_box.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

class UsbFormatPage extends ConsumerStatefulWidget {
  const UsbFormatPage({super.key});

  @override
  ConsumerState<UsbFormatPage> createState() => _UsbFormatPageState();
}

class _UsbFormatPageState extends ConsumerState<UsbFormatPage> {
  static final Uri _paypalUri = Uri.parse('https://paypal.me/avdoviic');
  static final Uri _fiverrUri = Uri.parse('https://www.fiverr.com/emiravdovic');
  late final TextEditingController _volumeController;

  @override
  void initState() {
    super.initState();
    _volumeController = TextEditingController();
    _volumeController.addListener(_onVolumeChanged);
  }

  @override
  void dispose() {
    _volumeController.removeListener(_onVolumeChanged);
    _volumeController.dispose();
    super.dispose();
  }

  void _onVolumeChanged() {
    ref
        .read(usbFormatControllerProvider.notifier)
        .updateVolumeName(_volumeController.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UsbFormatState>(usbFormatControllerProvider, (previous, next) {
      final feedback = next.feedback;
      if (feedback != null && feedback != previous?.feedback && mounted) {
        _showSnackBar(
          _feedbackMessage(feedback, volumeNameError: next.volumeNameError),
          isError: true,
        );
        ref.read(usbFormatControllerProvider.notifier).consumeFeedback();
      }
    });

    final state = ref.watch(usbFormatControllerProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktopLayout = ResponsiveUtils.isDesktopLayout(context);
    final maxWidth = ResponsiveUtils.maxContentWidth(
      screenWidth,
      isDesktop: isDesktopLayout,
    );
    final compactHeader =
        !isDesktopLayout && ResponsiveUtils.isCompactHeight(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(
      screenWidth,
      isDesktop: isDesktopLayout,
    );
    final formPadding = ResponsiveUtils.formCardPadding(
      screenWidth,
      isDesktop: isDesktopLayout,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primaryPurple,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    isDesktopLayout ? 26 : 10,
                    horizontalPadding,
                    MediaQuery.of(context).viewInsets.bottom + 28,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isDesktopLayout ? 920 : maxWidth,
                            ),
                            child: UsbHeaderSection(
                              compact: compactHeader,
                              isDesktop: isDesktopLayout,
                              topAction: LanguageSelector(
                                isDesktop: isDesktopLayout,
                              ),
                            ),
                          ),
                          SizedBox(height: isDesktopLayout ? 14 : 10),
                          Center(
                            child: SizedBox(
                              width: isDesktopLayout ? 460 : null,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: isDesktopLayout ? 460 : 420,
                                ),
                                child: SupportCreatorBanner(
                                  isDesktop: isDesktopLayout,
                                  onTap: _openPayPal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: isDesktopLayout ? 10 : 8),
                          Center(
                            child: CreatorCreditChip(
                              isDesktop: isDesktopLayout,
                              onTap: _openFiverr,
                            ),
                          ),
                          SizedBox(height: isDesktopLayout ? 34 : 12),
                          if (isDesktopLayout)
                            _buildFormCard(
                              state: state,
                              availableWidth: maxWidth - (formPadding * 2),
                              formPadding: formPadding,
                              isDesktopLayout: true,
                            )
                          else
                            Transform.translate(
                              offset: const Offset(0, -10),
                              child: _buildFormCard(
                                state: state,
                                availableWidth: constraints.maxWidth,
                                formPadding: formPadding,
                                isDesktopLayout: false,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard({
    required UsbFormatState state,
    required double availableWidth,
    required double formPadding,
    required bool isDesktopLayout,
  }) {
    return Container(
      padding: EdgeInsets.all(formPadding),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withValues(
          alpha: isDesktopLayout ? 0.96 : 1,
        ),
        borderRadius: BorderRadius.circular(isDesktopLayout ? 40 : 30),
        border: isDesktopLayout
            ? Border.all(color: Colors.white.withValues(alpha: 0.16))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDesktopLayout ? 0.14 : 0.12,
            ),
            blurRadius: isDesktopLayout ? 36 : 30,
            offset: Offset(0, isDesktopLayout ? 22 : 18),
          ),
        ],
      ),
      child: _buildFormContent(
        state: state,
        availableWidth: availableWidth,
        isDesktopLayout: isDesktopLayout,
      ),
    );
  }

  Widget _buildFormContent({
    required UsbFormatState state,
    required double availableWidth,
    required bool isDesktopLayout,
  }) {
    if (!isDesktopLayout) {
      return _buildMobileFormContent(
        state: state,
        availableWidth: availableWidth,
      );
    }

    final leftColumnWidth = (availableWidth - 28) * 0.6;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _buildDeviceAndFormatColumn(
            state: state,
            availableWidth: leftColumnWidth,
            isDesktopLayout: true,
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 4,
          child: _buildDetailsColumn(state: state, isDesktopLayout: true),
        ),
      ],
    );
  }

  Widget _buildMobileFormContent({
    required UsbFormatState state,
    required double availableWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDeviceAndFormatColumn(
          state: state,
          availableWidth: availableWidth,
          isDesktopLayout: false,
        ),
        const SizedBox(height: 26),
        _buildDetailsColumn(state: state, isDesktopLayout: false),
      ],
    );
  }

  Widget _buildDeviceAndFormatColumn({
    required UsbFormatState state,
    required double availableWidth,
    required bool isDesktopLayout,
  }) {
    final l10n = context.l10n;
    final sectionSpacing = isDesktopLayout ? 30.0 : 26.0;
    final cardSpacing = isDesktopLayout ? 18.0 : 14.0;
    final gridSpacing = isDesktopLayout ? 20.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          icon: Icons.usb_rounded,
          title: l10n.chooseDevice,
          trailing: IconButton(
            onPressed: state.isFormatting ? null : _handleRefreshTap,
            tooltip: l10n.refreshDevices,
            iconSize: isDesktopLayout ? 38 : 28,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ),
        SizedBox(height: cardSpacing),
        if (state.hasDevices || state.isLoadingDevices)
          UsbDeviceDropdown(
            selectedDevice: state.selectedDevice,
            isLoading: state.isLoadingDevices,
            onTap: _handleDeviceTap,
            isDesktop: isDesktopLayout,
          )
        else
          EmptyDevicesState(
            onRetry: _handleRefreshTap,
            isDesktop: isDesktopLayout,
          ),
        if (state.selectedDevice != null) ...[
          SizedBox(height: isDesktopLayout ? 20 : 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: UsbDeviceCard(
              key: ValueKey(state.selectedDevice!.id),
              device: state.selectedDevice!,
              isDesktop: isDesktopLayout,
            ),
          ),
        ],
        SizedBox(height: sectionSpacing),
        SectionTitle(icon: Icons.tune_rounded, title: l10n.chooseFormat),
        SizedBox(height: cardSpacing),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: FileSystemFormat.values.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveUtils.formatGridCrossAxisCount(
              availableWidth,
              isDesktop: isDesktopLayout,
            ),
            mainAxisSpacing: gridSpacing,
            crossAxisSpacing: gridSpacing,
            childAspectRatio: ResponsiveUtils.formatGridAspectRatio(
              availableWidth,
              isDesktop: isDesktopLayout,
            ),
          ),
          itemBuilder: (context, index) {
            final format = FileSystemFormat.values[index];
            return FormatOptionCard(
              format: format,
              isSelected: state.selectedFormat == format,
              isDesktop: isDesktopLayout,
              onTap: () => _selectFormat(format),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDetailsColumn({
    required UsbFormatState state,
    required bool isDesktopLayout,
  }) {
    final l10n = context.l10n;
    final sectionSpacing = isDesktopLayout ? 26.0 : 20.0;
    final cardSpacing = isDesktopLayout ? 18.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          icon: Icons.drive_file_rename_outline_rounded,
          title: l10n.volumeNameOptional,
        ),
        SizedBox(height: cardSpacing),
        VolumeNameField(
          controller: _volumeController,
          errorText: _volumeNameErrorText(state.volumeNameError),
        ),
        SizedBox(height: sectionSpacing),
        QuickFormatTile(
          value: state.quickFormatEnabled,
          isDesktop: isDesktopLayout,
          onChanged: (value) {
            HapticFeedback.selectionClick();
            ref
                .read(usbFormatControllerProvider.notifier)
                .toggleQuickFormat(value);
          },
        ),
        const SizedBox(height: 16),
        WarningBox(isDesktop: isDesktopLayout),
        SizedBox(height: isDesktopLayout ? 24 : 20),
        PrimaryGradientButton(
          label: l10n.startFormatting,
          icon: Icons.rocket_launch_rounded,
          enabled: state.canStartFormatting,
          isLoading: state.isFormatting,
          isDesktop: isDesktopLayout,
          onPressed: _startFormattingFlow,
        ),
      ],
    );
  }

  Future<void> _handleRefresh() async {
    if (ref.read(usbFormatControllerProvider).isFormatting) {
      return;
    }

    await ref.read(usbFormatControllerProvider.notifier).refreshDevices();

    if (!mounted) {
      return;
    }

    final state = ref.read(usbFormatControllerProvider);
    _showSnackBar(
      state.devices.isEmpty
          ? context.l10n.noDevicesFoundShort
          : context.l10n.listRefreshed,
    );
  }

  void _handleRefreshTap() {
    unawaited(_handleRefresh());
  }

  void _handleDeviceTap() {
    final state = ref.read(usbFormatControllerProvider);
    FocusScope.of(context).unfocus();

    if (ResponsiveUtils.isDesktopLayout(context)) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: UsbDevicePickerSheet(
                devices: state.devices,
                selectedDevice: state.selectedDevice,
                isDesktopDialog: true,
                onRetry: () {
                  Navigator.of(context).pop();
                  _handleRefreshTap();
                },
                onSelected: (device) {
                  HapticFeedback.selectionClick();
                  ref
                      .read(usbFormatControllerProvider.notifier)
                      .selectDevice(device);
                  Navigator.of(context).pop();
                  _showSnackBar(context.l10n.deviceSelected(device.name));
                },
              ),
            ),
          );
        },
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return UsbDevicePickerSheet(
          devices: state.devices,
          selectedDevice: state.selectedDevice,
          onRetry: () {
            Navigator.of(context).pop();
            _handleRefreshTap();
          },
          onSelected: (device) {
            HapticFeedback.selectionClick();
            ref.read(usbFormatControllerProvider.notifier).selectDevice(device);
            Navigator.of(context).pop();
            _showSnackBar(context.l10n.deviceSelected(device.name));
          },
        );
      },
    );
  }

  void _selectFormat(FileSystemFormat format) {
    HapticFeedback.selectionClick();
    ref.read(usbFormatControllerProvider.notifier).selectFormat(format);
  }

  Future<void> _openPayPal() async {
    HapticFeedback.selectionClick();

    final launched = await launchUrl(
      _paypalUri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      _showSnackBar(context.l10n.couldNotOpenSupportLink, isError: true);
    }
  }

  Future<void> _openFiverr() async {
    HapticFeedback.selectionClick();

    final launched = await launchUrl(
      _fiverrUri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      _showSnackBar(context.l10n.couldNotOpenCreatorLink, isError: true);
    }
  }

  Future<void> _startFormattingFlow() async {
    final notifier = ref.read(usbFormatControllerProvider.notifier);
    final state = ref.read(usbFormatControllerProvider);
    FocusScope.of(context).unfocus();

    final validationError = notifier.validateBeforeFormatting();
    if (validationError != null) {
      HapticFeedback.heavyImpact();
      return;
    }

    final device = state.selectedDevice;
    if (device == null) {
      return;
    }

    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmationDialog(
            device: device,
            format: state.selectedFormat,
            volumeName: state.volumeName,
            quickFormatEnabled: state.quickFormatEnabled,
          ),
        ) ??
        false;

    if (!confirmed || !mounted) {
      return;
    }

    HapticFeedback.mediumImpact();
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => const FormattingProgressDialog(),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 80));
    final success = await notifier.startFormatting();

    if (!mounted) {
      return;
    }

    final rootNavigator = Navigator.of(context, rootNavigator: true);
    if (rootNavigator.canPop()) {
      rootNavigator.pop();
    }

    if (!success) {
      return;
    }

    await _showSuccessDialog(
      device,
      ref.read(usbFormatControllerProvider).selectedFormat,
    );
    ref.read(usbFormatControllerProvider.notifier).clearFormattingFeedback();
    if (mounted) {
      _showSnackBar(context.l10n.deviceReadyForUse);
    }
  }

  Future<void> _showSuccessDialog(
    UsbDevice device,
    FileSystemFormat format,
  ) async {
    final l10n = context.l10n;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 32,
            ),
          ),
          title: Text(l10n.formattingSuccessTitle),
          content: Text(
            l10n.formattingSuccessMessage(device.name, format.displayName),
            style: AppTextStyles.cardSubtitle.copyWith(
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.close),
            ),
          ],
        );
      },
    );
  }

  String? _volumeNameErrorText(VolumeNameValidationError? error) {
    if (error == null) {
      return null;
    }

    return context.l10n.volumeNameValidationMessage(error);
  }

  String _feedbackMessage(
    UsbFormatFeedback feedback, {
    VolumeNameValidationError? volumeNameError,
  }) {
    return context.l10n.feedbackMessage(
      feedback,
      volumeNameError: volumeNameError,
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: isError ? AppColors.red : AppColors.dark,
          content: Text(message),
        ),
      );
  }
}
