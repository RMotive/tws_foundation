import 'package:csm_client_core/csm_client_core.dart';

abstract interface class TWSViewConsumeAdapter {
  Future<List<ViewOutput<dynamic>>> consume(ViewInput<dynamic> input);
}
