import 'dart:async';

import 'package:csm_client/csm_client.dart';

///
typedef AuthBuilder = FutureOr<String> Function();

///
typedef EntityBuilder<TEntity extends EntityI<TEntity>> = TEntity Function();
