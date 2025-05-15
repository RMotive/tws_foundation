import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/src/core/foundation_colors.dart';
import 'package:tws_widgets/tws_widgets.dart';

part 'tws_article_table_details/tws_article_table_details.dart';
part 'tws_article_table_details/tws_article_table_details_action.dart';
part 'tws_article_table_details/tws_article_table_details_state.dart';
part 'tws_article_table_details/tws_article_table_editor.dart';

part 'tws_article_table_header/tws_article_table_header.dart';

part 'tws_article_table_error.dart';
part 'tws_article_table_loading.dart';
/// [TWSArticleTable] Create a data grid table, with custom headers, content and interactable rows and drawer options.
class TWSArticleTable<TArticle extends EntityB<TArticle>> extends StatefulWidget {
  /// Set the columns in the table and it's content.
  final List<TWSArticleTableFieldOptions<TArticle>> fields;
  /// Adapter for the selected row drawer options: Update and delete row record options.
  final TWSArticleTableAdapter<TArticle> adapter;
  /// Table agent with reflesh methods.
  final TWSArticleTableAgent? agent;
  /// Title text showed in top of the drawer.
  final String viewerTitle;
  /// Enabled the drawer record update button.
  final bool editable;
  /// Enabled the delete record button.
  final bool removable;
  /// Initial records page.
  final int page;
  /// Size per page.
  final int size;
  /// List of available sizes per page.
  final List<int> sizes;

  const TWSArticleTable({
    super.key,
    this.editable = true,
    this.removable = true,
    this.viewerTitle = "Record",
    this.page = 1,
    this.agent,
    required this.size,
    required this.sizes,
    required this.fields,
    required this.adapter,
  });

  @override
  State<TWSArticleTable<TArticle>> createState() => _TWSArticleTableState<TArticle>();
}

class _TWSArticleTableState<TArticle extends EntityB<TArticle>> extends State<TWSArticleTable<TArticle>> with SingleTickerProviderStateMixin {
  static const double _kPagingHeight = 50;
  static const double _kMinFieldWidth = 200;
  static const double _kDetailsWidth = 400;

  /// Data consume function.
  late Future<ViewOutput<TArticle>> Function() consume;
  /// Drawer animation controller.
  late AnimationController detailsAnimationController;
  /// Horizontal scroll controller.
  late ScrollController horizontalController;
  /// Initialize consumer agent.
  final AsyncWidgetController agent = AsyncWidgetController();

  late final TWSArticleTableAdapter<TArticle> adapter;

  // --> State resources
  /// Current selected item.
  late (int index, TArticle item)? selected;
  /// Current page records.
  late List<TArticle> records;
  /// The total quantity of available records at the data storage.
  late int items;
  /// Current selected page.
  late int page;
  /// Total amount of pages available.
  late int pages;
  /// Current size selected.
  late int size;
  /// Available page sizes options.
  late final List<int> sizes;

  void updatePaging(int page, int size) async {
    setState(() {
      this.page = page;
      this.size = size;
      this.consume = () => adapter.consume(size, page, <ViewOrdering>[]);
    });
    agent.refresh();
  }

  @override
  void initState() {
    selected = null;
    page = widget.page;
    horizontalController = ScrollController();
    sizes = widget.sizes;
    pages = page;
    size = widget.size;
    items = 0;
    adapter = widget.adapter;
    records = <TArticle>[];
    consume = () => adapter.consume(size, page, <ViewOrdering>[]);
    detailsAnimationController = AnimationController(
      vsync: this,
      duration: 200.miliseconds,
      animationBehavior: AnimationBehavior.preserve,
    );
    widget.agent?.addListener(agent.refresh);
    super.initState();
  }

  @override
  void dispose() {
    widget.agent?.removeListener(agent.refresh);
    detailsAnimationController.dispose();
    horizontalController.dispose();
    super.dispose();
  }

  void _updatePagingChanges(ViewOutput<TArticle> data) {
    // if (items != data.amount || pages != data.pages || records != data.sets) {
    if (items != data.count || pages != data.pages || records != data.entities) {
      WidgetsBinding.instance.addPostFrameCallback(
        (Duration timeStamp) {
          setState(() {
            records = data.entities;
            items = data.count;
            pages = data.pages;
          });
        },
      );
    }
  }

  void _selectRecord(int index, TArticle set) {
    setState(() {
      if (selected?.$1 == index) {
        selected = null;
        detailsAnimationController.reverse();
      } else {
        selected = (index, set);
        detailsAnimationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        BoxConstraints pageBounds = constrains;
        if (!constrains.hasBoundedHeight) {
          pageBounds = constrains.tighten(
            height: constrains.minHeight,
          );
        }

        final Size viewSize = pageBounds.biggest;
        final bool detailsFullDisplay = viewSize.width <= (_kDetailsWidth * 2);
        final Animation<double> detailsDisplayAnimation = Tween<double>(
          begin: 0,
          end: detailsFullDisplay ? viewSize.width : _kDetailsWidth,
        ).animate(detailsAnimationController);

        return SelectableRegion(
          focusNode: FocusNode(),
          selectionControls: MaterialTextSelectionControls(),
          child: SizedBox(
            width: viewSize.width,
            child: AnimatedBuilder(
              animation: detailsDisplayAnimation,
              builder: (_, __) {
                final double animationComputationValue = viewSize.width - detailsDisplayAnimation.value;
                final double cellWidth = animationComputationValue / widget.fields.length;

                return Stack(
                  children: <Widget>[
                    // --> Table
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: detailsFullDisplay ? viewSize.width : animationComputationValue,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // --> Table content
                          Expanded(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    width: 2,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              child: Scrollbar(
                                controller: horizontalController,
                                interactive: true,
                                child: SingleChildScrollView(
                                  controller: horizontalController,
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // --> Table header draw
                                      _TWSArticleTableHeader<TArticle>(
                                        fields: widget.fields,
                                        minFieldWidth: _kMinFieldWidth,
                                        fieldWidth: cellWidth,
                                      ),
                                      // --> Table items
                                      Expanded(
                                        child: AsyncWidget<ViewOutput<TArticle>>(
                                          future: consume,
                                          agent: agent,
                                          emptyCheck: (ViewOutput<TArticle> data) => data.entities.isEmpty,
                                          loadingBuilder: (_) => _TWSArticleTableLoading(viewSize: viewSize),
                                          errorBuilder: (_, __, ___) => _TWSArticleTableError(
                                            viewSize: viewSize,
                                          ),
                                          successBuilder: (_, ViewOutput<TArticle> data) {
                                            _updatePagingChanges(data);

                                            return SizedBox(
                                              height: pageBounds.maxHeight - 100,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: List<Widget>.generate(
                                                    data.entities.length,
                                                    (int index) {
                                                      return PointerArea(
                                                        cursor: SystemMouseCursors.click,
                                                        onClick: () => _selectRecord(index, data.entities[index]),
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                            color: selected?.$1 == index ? Colors.blueGrey : Colors.transparent,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              for (int cont = 0; cont < widget.fields.length; cont++)
                                                                ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    minWidth: widget.fields[cont].width ?? _kMinFieldWidth,
                                                                  ),
                                                                  child: SizedBox(
                                                                    width: widget.fields[cont].width ?? cellWidth,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                        vertical: 6,
                                                                        horizontal: 8,
                                                                      ),
                                                                      child: Builder(builder: (BuildContext context) {
                                                                        final String cellValue = widget.fields[cont].factory(data.entities[index], index, context);
                                                                        final Widget textWidget = Text(
                                                                          cellValue,
                                                                          maxLines: 2,
                                                                          style: TextStyle(
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        );

                                                                        if (!widget.fields[cont].tip) {
                                                                          return textWidget;
                                                                        }
                                                                        return Tooltip(
                                                                          message: cellValue,
                                                                          child: textWidget,
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // --> Paging selection
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: animationComputationValue,
                            ),
                            child: SizedBox(
                              height: _kPagingHeight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: TWSPagingSelector(
                                  pages: pages,
                                  size: size,
                                  items: records.length,
                                  sizes: sizes,
                                  total: items,
                                  onChange: updatePaging,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // --> Item detail
                    if (selected != null)
                      Positioned(
                        left: animationComputationValue,
                        width: detailsFullDisplay ? viewSize.width : _kDetailsWidth,
                        height: viewSize.height,
                        child: _TWSArticleTableDetails<TArticle>(
                          viewerTitle: widget.viewerTitle,
                          editable: widget.editable,
                          removable: widget.removable,
                          adapter: widget.adapter,
                          record: selected!.$2,
                          closeAction: () {
                            if (selected != null) {
                              _selectRecord(selected!.$1, selected!.$2);
                            }
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
