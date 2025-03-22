
import 'dart:async';

import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [ViewConsumeAdapter] Mock for async view consume simulation.
final class ViewConsumeAdapter implements TWSViewConsumeAdapter{
  const ViewConsumeAdapter();
  
  @override
  Future<List<SetViewOut<Feature>>> consume(int page, int range, List<SetViewOrderOptions> orderings, String input) async {
    late SetViewOut<Feature> setviewMock;
    await Future<void>.delayed(Duration(seconds: 1));
    setviewMock = SetViewOut<Feature>(
        <Feature>[
          Feature(1, "Feature 1", "description 1"),
          Feature(2, "Feature 2", "description 2"),
          Feature(3, "Feature 3", "description 3"),
          Feature(4, "Feature 4", "description 4"),
          Feature(5, "Feature 5", "description 5"),
          Feature(6, "Feature 6", "description 6"),
        ],
        page,
        DateTime.now(),
        1,
        15,
        15,
      );

    return <SetViewOut<Feature>>[setviewMock];
  }
}