import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [TWSViewConsumeAdapter] Consume adapter for sets view.
abstract interface class TWSViewConsumeAdapter {
  Future<List<ViewOutput<dynamic>>> consume(int range, int pages, String input);
}
