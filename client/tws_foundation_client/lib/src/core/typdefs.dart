import 'package:csm_client/csm_client.dart';

typedef Effect<TEstela extends EncodableI> = Future<ResponseResolverB<TEstela>>;
typedef MResolver<TEstela extends EncodableI> = ResponseResolverB<TEstela>;

