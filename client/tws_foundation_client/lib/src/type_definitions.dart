import 'package:tws_foundation_client/tws_foundation_client.dart';

typedef Effect<TEstela extends EncodableI> = Future<ServiceResolver<TEstela>>;
typedef MResolver<TEstela extends EncodableI> = ServiceResolver<TEstela>;
