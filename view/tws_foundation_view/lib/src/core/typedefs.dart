import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';

///
typedef AuthBuilder = FutureOr<String> Function();

///
typedef EntityBuilder<TEntity extends IEntity<TEntity>> = TEntity Function();
