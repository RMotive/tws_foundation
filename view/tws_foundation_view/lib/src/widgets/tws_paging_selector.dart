import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/tws_dropup.dart';

/// [TWSPagingSelector] Widget Row that shows paging data and paging selector,
/// ideal for data tables.
class TWSPagingSelector extends StatefulWidget {
  /// Current view items.
  final int items;

  /// Total available items.
  final int total;

  /// Current page.
  final int page;

  /// Total available pages.
  final int pages;

  /// Size for all pages.
  final int size;

  /// Pages size options.
  final List<int> sizes;

  /// Trigger method on select new page or size pages.
  final void Function(int page, int size) onChange;

  const TWSPagingSelector({
    super.key,
    this.page = 1,
    this.items = 0,
    this.total = 0,
    required this.pages,
    required this.size,
    required this.sizes,
    required this.onChange,
  });

  @override
  State<TWSPagingSelector> createState() => _TWSPagingSelectorState();
}

class _TWSPagingSelectorState extends State<TWSPagingSelector> {
  /// Theme Manager injector.
  final ThemeManagerI<FoundationThemeB> themeManager =
      Injector.getThemeManager();

  /// Theme reference key.
  final UniqueKey ref = UniqueKey();

  /// Color pallet for the component.
  late SimpleTheming pageTheme;

  late int page;
  late int size;

  void themeUpdateListener(FoundationThemeB theme) {
    setState(() {
      pageTheme = theme.page;
    });
  }

  @override
  void initState() {
    page = widget.page;
    size = widget.size;
    themeManager.addEffect(ref, themeUpdateListener);
    pageTheme = themeManager.get().page;
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeEffect(ref);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool disabled = widget.pages <= 1;
    print('rebuild');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // --> Items indicator
        ResponsiveWidget(
          onLarge: RichText(
            text: TextSpan(
              text: 'Showing ',
              style: TextStyle(
                color: pageTheme.fore,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(${widget.items})',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const TextSpan(text: ' records from '),
                TextSpan(
                  text: '(${widget.total})',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          onSmall: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'Showing',
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 10,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' (${widget.total})',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'from',
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 10,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' (${widget.items})',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20,
            children: <Widget>[
              // --> Page range selector
              TWSDropup<int>(
                disabled: disabled,
                tooltip: 'Page range selection',
                item: widget.size,
                items: widget.sizes,
                onChange: (int size) {
                  setState(() {
                    this.size = size;
                  });
                  widget.onChange(page, size);
                },
              ),
              // --> Page selector
              TWSDropup<int>(
                disabled: disabled,
                tooltip: 'Page selection',
                item: widget.page,
                onChange: (int page) {
                  setState(() {
                    this.page = page;
                  });
                  widget.onChange(page, size);
                },
                items: List<int>.generate(widget.pages, (int i) => i + 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
