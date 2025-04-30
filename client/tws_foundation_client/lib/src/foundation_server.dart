import 'package:csm_client/csm_client.dart';

/// {implementation} class for a [ServerB].
///
///
/// Defines the base behavior for a [FoundationServer] that handles the network address to communicate with a [FoundationServer] and its [ServiceI] implementations.
final class FoundationServer extends ServerB {
  /// Creates a new [FoundationServer] instance.
  FoundationServer()
      : super(
          Uri(
            'localhost',
            '',
            port: 5195,
          ),
        );
}
