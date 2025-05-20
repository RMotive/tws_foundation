import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tws_foundation_view/src/themes/twsf_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/tws_button_flat.dart';

/// [TWSConfirmationDialog] Widget designed to be implemented in a [showdialog] method.
/// Displays a dialog window with a header, body content and confirmation action buttons.
final class TWSConfirmationDialog extends StatefulWidget {
  /// Dialog title.
  final String title;
  /// Text content.
  final Text? statement;
  /// Show an optional cancel button.
  final bool showCancelButton;
  /// Accept button text.
  final String accept;
  /// Trigger on close dialog.
  final VoidCallback? onClose;
  /// Trigger on accept dialog.
  final FutureOr<void> Function()? onAccept;

  const TWSConfirmationDialog({
    super.key,
    this.onClose,
    this.onAccept,
    this.statement,
    this.showCancelButton = true,
    this.title = 'Confirmation',
    this.accept = 'Accept',
  });

  @override
  State<TWSConfirmationDialog> createState() => _TWSConfirmationDialogState();
}

class _TWSConfirmationDialogState extends State<TWSConfirmationDialog> {

  late TWSFThemeB theme;

  /// Theme Manager injector.
  final ThemeManagerI<TWSFThemeB> themeManager = Injector.getThemeManager();

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  /// Color pallet for the component.
  late SimpleTheming pageTheme;
  late SimpleTheming dangerTheme;

  bool loading = false;

  @override
  void initState() {
    ServicesBinding.instance.keyboard.addHandler(_keyHandler);
    themeManager.addEffect(ref, themeUpdateListener);
    theme = themeManager.get();
    pageTheme = theme.page;
    dangerTheme = theme.primaryCriticalControl;

    super.initState();
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_keyHandler);
    themeManager.removeEffect(ref);
    super.dispose();
  }

  void themeUpdateListener(TWSFThemeB theme) {
    setState(() {
      this.theme = theme;
      pageTheme = theme.page;
      dangerTheme = theme.primaryCriticalControl;
    });
  }


  bool _keyHandler(KeyEvent event) {
    final String key = event.logicalKey.keyLabel;

    if (event is KeyDownEvent) {
      if (key == 'Escape' && !loading) {
        widget.onClose?.call();
        Navigator.of(context).pop();
      }
    }
    return false;
  }

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {

    final SimpleTheming pageTheme = theme.page;
    final SimpleTheming dangerTheme = theme.primaryCriticalControl;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (loading) {
          return;
        }

        widget.onClose?.call();
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 450,
            ),
            child: GestureDetector(
              onTap: () {},
              child: ColoredBox(
                color: pageTheme.back,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // --> Dialog header
                    ColoredBox(
                      color: pageTheme.accent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.title,
                              style: TextStyle(
                                color:  pageTheme.accentAlt ?? pageTheme.fore,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: loading ? null : () => _close(context),
                                    icon: Icon(
                                      Icons.close,
                                      color: dangerTheme.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // --> Dialog body
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: pageTheme.fore,
                            ),
                            child: widget.statement ??
                                const Text(
                                  'Are you sure you want to continue?',
                                ),
                          ),
                        ),
                      ),
                    ),
                    // --> Dialog footer
                    ColoredBox(
                      color: pageTheme.accent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Row(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TWSButtonFlat(
                              label: widget.accept,
                              onTap: () async {
                                if (widget.onAccept == null) {
                                  return;
                                }
                                loading = true;
                                await widget.onAccept!();
                                loading = false;
                              },
                            ),
                            Visibility(
                              visible: widget.showCancelButton,
                              child: TWSButtonFlat(
                                label: 'Cancel',
                                disabled: loading,
                                themeOptions: dangerTheme,
                                onTap: () => _close(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
