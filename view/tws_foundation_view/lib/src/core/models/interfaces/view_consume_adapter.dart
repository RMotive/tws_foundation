import 'package:tws_foundation_client/tws_foundation_client.dart';

/// [ViewConsumeAdapter] Consume adapter for sets view.
abstract interface class ViewConsumeAdapter {
  Future<List<ViewOutput<dynamic>>> consume(int range, int pages, String input);
}
