import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/core/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/view/widgets/bordered_box.dart';
import 'package:tws_foundation_view/src/view/widgets/complex_widgets/entity_table/entity_table_adapter_b.dart';
import 'package:tws_foundation_view/src/view/widgets/pagination.dart';
import 'package:tws_foundation_view/src/view/widgets/tws_display_flat.dart';

part 'entity_table_theming.dart';

part 'entity_table_column_options.dart';

part '_entity_table_content.dart';
part '_entity_table_error.dart';
part '_entity_table_header.dart';
part '_entity_table_loader.dart';

part '_entity_table_drawer/_entity_table_drawer.dart';
part '_entity_table_drawer/_entity_table_drawer_action.dart';

/// Default column width.
const double _kColumnWidth = 200;

/// Default details drawer width
const double _kDetailsWidth = 400;

/// {widget} class.
///
/// [TEntity] type of the business [EntityB] implementation the table is based on.
///
/// Draws a complex data table with based on an [EntityB] implementation wich are business entities and part of the {solution}s Data Layer,
/// this tables are being built based on filtering, ordering and consuming {CSM} business scope services based on {view} generation engine.
final class EntityTable<TEntity extends EntityB<TEntity>, TService extends ViewServiceI<TEntity>>
    extends StatefulWidget {
  /// Initial paging page selection.
  final int page;

  /// Available ranges per page.
  final List<int> ranges;

  /// Object initialization factory, since Front-End frameworks don't use to have {reflections} to auto detect parameterless constructors.
  final TEntity Function() entityFactory;

  /// Table interactions adapter callbacks.
  final EntityTableAdapterB<TEntity> adapter;

  /// Column options.
  final List<EntityTableColumnOptions<TEntity>> columns;

  /// Creates a new [EntityTable] instance.
  const EntityTable({
    super.key,
    this.page = 1,
    this.ranges = const <int>[
      10,
      20,
      50,
      100,
      200,
    ],
    required this.adapter,
    required this.columns,
    required this.entityFactory,
  }) : assert(ranges.length > 0, 'Paging ranges must have at least one configured');

  @override
  State<EntityTable<TEntity, TService>> createState() => _EntityTableState<TEntity, TService>();
}

/// {state} class.
///
/// Defines [State] management class for [EntityTable].
final class _EntityTableState<TEntity extends EntityB<TEntity>, TService extends ViewServiceI<TEntity>>
    extends State<EntityTable<TEntity, TService>>
    with SingleTickerProviderStateMixin {
  /// {resource} initializes the [Animation] complex controller for the beside drawer table details.
  late final AnimationController drawerAnimationCtrl;

  /// {state} Current [Future] invokation result cached.
  late Future<ViewOutput<TEntity>> asyncInvokation;

  /// {state} [Pagination] widget options.
  late PaginationOptions paginationOptions;

  /// {state} Whether the table is loading new data.
  bool isLoading = false;

  /// {state} Current selected index item reference.
  int? selItem;

  @override
  void initState() {
    paginationOptions = PaginationOptions(
      total: 0,
      pageCount: 0,
      page: widget.page,
      pages: widget.page,
      ranges: widget.ranges,
      range: widget.ranges[0],
    );

    asyncInvokation = _viewInvokation();

    drawerAnimationCtrl = AnimationController(
      vsync: this,
      duration: 200.miliseconds,
      animationBehavior: AnimationBehavior.preserve,
    );

    widget.adapter.listenRefresh(refreshView);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EntityTable<TEntity, TService> oldWidget) {
    if (oldWidget.adapter != widget.adapter) {
      widget.adapter.listenRefresh(refreshView);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    drawerAnimationCtrl.dispose();
    super.dispose();
  }

  ///
  void refreshView() {
    if (mounted) {
      setState(() {
        selItem = null;
        drawerAnimationCtrl.reverse();
        asyncInvokation = _viewInvokation();
      });
    }
  }

  /// {event} triggered when the [EntityTable] pagination options has changed.
  void onPaginationChange(PaginationOptions newOptions) {
    this.paginationOptions = newOptions;
    refreshView();
  }

  /// {event} triggered when the item selection has changed.
  void onEntitySelectionChange(int? newSelItem) {
    if (newSelItem == selItem) return;
    setState(() {
      selItem = newSelItem;
    });

    if (newSelItem == null) {
      drawerAnimationCtrl.reverse();
    } else {
      drawerAnimationCtrl.forward();
    }
  }

  /// Invokes internally [ViewServiceI.view] service call.
  Future<ViewOutput<TEntity>> _viewInvokation() async {
    setState(() {
      isLoading = true;
      onEntitySelectionChange(null);
    });

    final TService viewService = Injector.get();

    final String auth = await widget.adapter.composeAuth();

    final FoundationResponseResolver<ViewOutput<TEntity>> viewOutputResolver = await viewService.view(
      ViewInput<TEntity>.b(paginationOptions.range, paginationOptions.page),
      auth,
    );

    final ViewOutput<TEntity> viewOutput = viewOutputResolver.resolveDirect(
      () => ViewOutput<TEntity>(widget.entityFactory),
    );

    setState(() {
      isLoading = false;
      paginationOptions = paginationOptions.clone(
        pages: viewOutput.pages,
        total: viewOutput.count,
        pageCount: viewOutput.length,
      );
    });

    return viewOutput;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        final Size boxSize = boxConstraints.biggest;
        final bool fullDrawer = boxSize.width <= (_kDetailsWidth * 2);

        final Animation<double> drawerAnimationTween = Tween<double>(
          begin: 0,
          end: fullDrawer ? boxSize.width : _kDetailsWidth,
        ).animate(drawerAnimationCtrl);

        return AnimatedBuilder(
          animation: drawerAnimationCtrl,
          builder: (_, _) {
            final double drawerAnimationValue = boxSize.width - drawerAnimationTween.value;
            final BoxConstraints drawerAnimationConstraint = BoxConstraints(
              minWidth: drawerAnimationValue,
            );

            return SizedBox.fromSize(
              size: boxSize,
              child: Stack(
                children: <Widget>[
                  /// --> Table Layout
                  SizedBox(
                    width: drawerAnimationValue,
                    height: boxSize.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// --> Table View
                        Expanded(
                          child: SizedBox(
                            width: drawerAnimationValue,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  /// --> Table header (column titles)
                                  ConstrainedBox(
                                    constraints: drawerAnimationConstraint,
                                    child: _EntityTableHeader<TEntity>(
                                      columns: widget.columns,
                                    ),
                                  ),

                                  /// --> Table content
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: AsyncWidget<ViewOutput<TEntity>>(
                                        future: asyncInvokation,
                                        loadingBuilder:
                                            (BuildContext ctx) => ConstrainedBox(
                                              constraints: drawerAnimationConstraint,
                                              child: _EntityTableLoader(),
                                            ),
                                        errorBuilder:
                                            (_, _, _) => ConstrainedBox(
                                              constraints: drawerAnimationConstraint,
                                              child: _EntityTableError(),
                                            ),
                                        successBuilder: (BuildContext buildContext, ViewOutput<TEntity> data) {
                                          return ConstrainedBox(
                                            constraints: drawerAnimationConstraint,
                                            child: Visibility(
                                              visible: data.entities.isNotEmpty,
                                              child: _EntityTableContent<TEntity>(
                                                preSelect: selItem,
                                                entities: data.entities,
                                                columns: widget.columns,
                                                onSelection: onEntitySelectionChange,
                                              ),
                                              replacement: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 16,
                                                ),
                                                child: Text(
                                                  'No entities found',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// --> Table footer (paging)
                        ConstrainedBox(
                          constraints: drawerAnimationConstraint,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Pagination(
                              disabled: isLoading,
                              options: paginationOptions,
                              onChange: onPaginationChange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// --> Drawer panel Layout.
                  Positioned(
                    left: drawerAnimationValue,
                    width: fullDrawer ? boxSize.width : _kDetailsWidth,
                    height: boxSize.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      child: _EntityTableDrawer<TEntity>(
                        selReference: selItem,
                        adapter: widget.adapter,
                        onCloseDrawer: () => onEntitySelectionChange(null),
                        viewInvokation: asyncInvokation,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
