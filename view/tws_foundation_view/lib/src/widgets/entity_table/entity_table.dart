import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/pagination.dart';
import 'package:tws_foundation_view/src/widgets/tws_display_flat.dart';
import 'package:tws_foundation_view/src/widgets/tws_frame_decoration.dart';

part '_entity_table_content.dart';
part '_entity_table_drawer/_entity_table_drawer.dart';
part '_entity_table_drawer/tws_article_table_details_action.dart';
part '_entity_table_drawer/tws_article_table_details_state.dart';
part '_entity_table_drawer/tws_article_table_editor.dart';
part '_entity_table_error.dart';
part '_entity_table_header.dart';
part '_entity_table_loader.dart';
part 'entity_table_column_options.dart';

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

  /// [ViewServiceI.view] methods use to need [auth] properties that represents an unique session auth token
  /// to authenticate operation, {FoundationView} package doesn't have access to this session managing context, reason why this
  /// callback generator is required.
  final FutureOr<String> Function() authGenerator;

  /// Object initialization factory, since Front-End frameworks don't use to have {reflections} to auto detect parameterless constructors.
  final TEntity Function() entityFactory;

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
    required this.columns,
    required this.authGenerator,
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

  /// {state} Current selected [TEntity] instance.
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

    super.initState();
  }

  @override
  void dispose() {
    drawerAnimationCtrl.dispose();
    super.dispose();
  }

  /// {event} triggered when the [EntityTable] pagination options has changed.
  void onPaginationChange(PaginationOptions newOptions) {
    setState(() {
      this.paginationOptions = newOptions;
      asyncInvokation = _viewInvokation();
    });
  }

  /// {event} triggered when the item selection has changed.
  void onEntitySelectionChange(int? newSelItem) {
    if (newSelItem == selItem) return;
    selItem = newSelItem;

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
    });

    final TService viewService = Injector.get();

    final String auth = await widget.authGenerator();

    final FoundationResponseResolver<ViewOutput<TEntity>> viewOutputResolver = await viewService.view(
      ViewInput<Solution>.b(paginationOptions.range, paginationOptions.page),
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

            return SizedBox.fromSize(
              size: boxSize,
              child: Stack(
                children: <Widget>[
                  /// --> Table Layout
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: drawerAnimationValue,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// --> Table header (column titles)
                          _EntityTableHeader<TEntity>(
                            columns: widget.columns,
                          ),

                          /// --> Table content
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: AsyncWidget<ViewOutput<TEntity>>(
                                future: asyncInvokation,
                                errorBuilder:
                                    (BuildContext ctx, Object? error, ViewOutput<TEntity>? data) => _EntityTableError(),
                                successBuilder:
                                    (BuildContext buildContext, ViewOutput<TEntity> data) =>
                                        _EntityTableContent<TEntity>(
                                          preSelect: selItem,
                                          entities: data.entities,
                                          columns: widget.columns,
                                          onSelection: onEntitySelectionChange,
                                        ),
                              ),
                            ),
                          ),

                          /// --> Table footer (paging)
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: boxConstraints.boxed().biggest.width,
                            ),
                            child: Pagination(
                              disabled: isLoading,
                              options: paginationOptions,
                              onChange: onPaginationChange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// --> Drawer panel Layout.
                  Positioned(
                    left: drawerAnimationValue,
                    width: fullDrawer ? boxSize.width : _kDetailsWidth,
                    height: boxSize.height,
                    child: _EntityTableDrawer<TEntity>(),
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
