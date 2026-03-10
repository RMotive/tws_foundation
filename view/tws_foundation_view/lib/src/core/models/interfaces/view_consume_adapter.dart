import 'package:csm_client_core/csm_client_core.dart';

/// [ViewConsumeAdapter] Consume adapter for sets view.
abstract interface class ViewConsumeAdapter {
  Future<List<ViewOutput<dynamic>>> consume(int range, int pages, String input);
}
