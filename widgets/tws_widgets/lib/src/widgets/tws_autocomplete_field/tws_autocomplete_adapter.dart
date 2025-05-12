import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract interface class TWSViewConsumeAdapter{
  Future<List<SetViewOutput<dynamic>>> consume(int page, int range, List<SetViewOutput<dynamic>> orderings, String input);
}