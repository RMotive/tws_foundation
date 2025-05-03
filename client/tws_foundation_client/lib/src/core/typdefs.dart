



import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {private} type definition for the [FoundationServer] custom [ResponseResolverI] implementation.
///
///
/// [T] type of the result data object of the resolved success data.
typedef FoundationFutureResolver<T extends DecodableI> = Future<FoundationResponseResolver<T>>;

///
///
///
typedef ServiceImplementationBuilder<T extends FoundationServiceB> = T Function(Uri serverUri, Client? serverClient);
