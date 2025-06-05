import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/constants.dart';
import 'package:tws_foundation_view/src/core/models/interfaces/tws_article_table_adapter.dart';
import 'package:tws_foundation_view/src/themes/foundation_theme_b.dart';
import 'package:tws_foundation_view/src/widgets/tws_display_flat.dart';
import 'package:tws_foundation_view/src/widgets/tws_frame_decoration.dart';

part '_entity_table_error.dart';
part '_entity_table_loader.dart';

part 'entity_table_column_options.dart';

part 'tws_article_table_details/tws_article_table_details.dart';
part 'tws_article_table_details/tws_article_table_details_action.dart';
part 'tws_article_table_details/tws_article_table_details_state.dart';
part 'tws_article_table_details/tws_article_table_editor.dart';
part 'tws_article_table_header/tws_article_table_header.dart';

/// {widget} class.
///
/// [TEntity] type of the business [EntityB] implementation the table is based on.
///
/// Draws a complex data table with based on an [EntityB] implementation wich are business entities and part of the {solution}s Data Layer,
/// this tables are being built based on filtering, ordering and consuming {CSM} business scope services based on {view} generation engine.
final class EntityTable<TEntity extends EntityB<TEntity>, TService extends ViewServiceI> extends StatefulWidget {
  /// Initial paging page selection.
  final int page;

  /// Available ranges per page.
  final List<int> ranges;

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
  }) : assert(ranges.length > 0, 'Paging ranges must have at least one configured');

  @override
  State<EntityTable<TEntity>> createState() => _EntityTableState<TEntity>();
}

/// {state} class.
///
/// Defines [State] management class for [EntityTable].
final class _EntityTableState<TEntity extends EntityB<TEntity>> extends State<EntityTable<TEntity>>
    with SingleTickerProviderStateMixin {
  ///
  late Future<ViewOutput<TEntity>> Function() asyncInvokation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncWidget<ViewOutput<TEntity>>(
      future: asyncInvokation,
      successBuilder: (BuildContext ctx, ViewOutput<TEntity> data) {
        return Center(
          child: Text(
            'Entity Table Consumed',
          ),
        );
      },
    );
  }
}
