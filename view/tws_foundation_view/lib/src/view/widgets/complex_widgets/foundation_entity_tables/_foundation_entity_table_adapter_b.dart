import 'dart:async';

import 'package:csm_client/csm_client.dart';
import 'package:csm_view/csm_view.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {abstract} class.
///
/// Implements and defines base behavior for {foundation} specific [EntityTableAdapterB] implementations to simplify the shared
/// properties and behaviors along {foundation} entity tables adaters.
abstract class FoundationEntityTableAdapterB<TEntity extends EntityI<TEntity>> extends EntityTableAdapterB<TEntity> {
  /// Callback to get authentication token due to some operations handled by the inner [EntityTable] requires authenticated service calls.
  final FutureOr<String> Function()? authBuilder;

  /// Creates a new [FoundationEntityTableAdapterB] instance.
  FoundationEntityTableAdapterB({
    required this.authBuilder,
  });

  @override
  FutureOr<String> composeAuth() {
    if (authBuilder != null) return authBuilder!();

    return Injector.get<SessionStorageI>().token;
  }
}
