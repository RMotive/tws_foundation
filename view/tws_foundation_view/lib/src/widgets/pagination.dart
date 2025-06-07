import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/drop_up.dart';

/// {model} class.
///
/// Defines an options data model class to specify how [Pagination] widget will draw an behave.
final class PaginationOptions {
  /// Current data page.
  final int page;

  /// Actual total of available data pages.
  final int pages;

  /// Items range per page.
  final int range;

  /// Available ranges selection.
  final List<int> ranges;

  /// Actual quanity of items calcualted for this page.
  final int pageCount;

  /// Actual total quantity of items withouth paging.
  final int total;

  /// Creates a new [PaginationOptions] instance.
  PaginationOptions({
    required this.range,
    required this.page,
    required this.pages,
    required this.ranges,
    required this.total,
    required this.pageCount,
  });

  ///
  PaginationOptions clone({
    int? page,
    int? pages,
    int? range,
    List<int>? ranges,
    int? pageCount,
    int? total,
  }) {
    return PaginationOptions(
      range: range ?? this.range,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      ranges: ranges ?? this.ranges,
      total: total ?? this.total,
      pageCount: pageCount ?? this.pageCount,
    );
  }
}

/// {widget} class.
///
/// Draws and handles a pagination handler [Widget] to simplify data paging selection options.
final class Pagination extends StatefulWidget {
  /// Whether the [Widget] interactions must be disabled.
  final bool disabled;

  /// [Widget] pagination options.
  final PaginationOptions options;

  /// Trigger method on select new [page] or [range] pages.
  final void Function(PaginationOptions paginationOptions) onChange;

  /// Creates a new [Pagination] instance.
  const Pagination({
    this.disabled = false,
    required this.options,
    required this.onChange,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  /// Theme effect reference key.
  final UniqueKey themingRef = UniqueKey();

  /// {state} {theming} Theming options for application page.
  late SimpleTheming pageTheming;

  /// {state} Current pagination options calculations.
  late PaginationOptions options;

  @override
  void initState() {
    options = widget.options;

    pageTheming = Theming.get<FoundationThemeB>().page;
    Injector.getThemeManager<FoundationThemeB>().addEffect(
      themingRef,
      (FoundationThemeB theme) {
        setState(() {
          pageTheming = theme.page;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    Injector.getThemeManager().removeEffect(themingRef);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Pagination oldWidget) {
    if (widget.options != options) {
      options = widget.options;
    }

    super.didUpdateWidget(oldWidget);
  }

  /// {event}
  void onRangeChange(int newRange) {
    setState(() {
      options = options.clone(
        range: newRange,
      );
      widget.onChange(options);
    });
  }

  /// {event}
  void onPageChange(int newPage) {
    setState(() {
      options = options.clone(
        page: newPage,
      );
      widget.onChange(options);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /// --> Current data indicator
        ResponsiveWidget(
          onLarge: RichText(
            text: TextSpan(
              text: 'Showing ',
              style: TextStyle(
                color: pageTheming.fore,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(${options.pageCount})',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const TextSpan(text: ' records from '),
                TextSpan(
                  text: '(${options.total})',
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
                      text: ' (${options.pageCount})',
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
                      text: ' (${options.total})',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// --> Pagination controls
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20,
            children: <Widget>[
              /// --> Page range selector
              DropUp<int>(
                disabled: widget.disabled,
                tooltip: 'Page range selection',
                item: options.range,
                items: options.ranges,
                onChange: onRangeChange,
              ),
              // --> Page selector
              DropUp<int>(
                disabled: widget.disabled,
                tooltip: 'Page selection',
                item: options.page,
                items: List<int>.generate(
                  options.pages,
                  (int i) => i + 1,
                ),
                onChange: onPageChange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
