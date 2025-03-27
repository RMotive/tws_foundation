import 'package:tws_foundation_client/tws_foundation_client.dart';

typedef Effect<TEstela extends CSMEncodeInterface> = Future<ServiceResolver<TEstela>>;
typedef MResolver<TEstela extends CSMEncodeInterface> = ServiceResolver<TEstela>;
