import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_formater/app/app.dart';
import 'package:usb_formater/features/usb_format/presentation/pages/usb_format_page.dart';
import 'package:usb_formater/l10n/app_localizations.dart';

void main() {
  testWidgets('USB Format ekran se prikazuje', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: UsbFormatApp()));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(UsbFormatPage));
    final l10n = AppLocalizations.of(context);

    expect(find.text(l10n.heroTitle), findsOneWidget);
    expect(find.text(l10n.startFormatting), findsOneWidget);
    expect(find.text(l10n.chooseDevice), findsOneWidget);
  });
}
