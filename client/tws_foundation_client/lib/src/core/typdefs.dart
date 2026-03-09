import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

typedef Effect<TEstela extends IDecodable?> = Future<FoundationResponseResolver<TEstela>>;
typedef MResolver<TEstela extends IDecodable?> = FoundationResponseResolver<TEstela>;

/// {private} type definition for the [FoundationServer] custom [IResponseResolver] implementation.
///
///
/// [T] type of the result data object of the resolved success data.
typedef FoundationFutureResolver<T extends IDecodable?> = Future<FoundationResponseResolver<T>>;

///
///
///
typedef ServiceImplementationBuilder<T extends FoundationServiceB> = T Function(Uri serverUri, Client? serverClient);
