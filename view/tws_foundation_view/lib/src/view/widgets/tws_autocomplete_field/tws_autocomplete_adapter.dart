import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract interface class TWSViewConsumeAdapter {
  Future<List<ViewOutput<dynamic>>> consume(ViewInput<dynamic> input);
}
