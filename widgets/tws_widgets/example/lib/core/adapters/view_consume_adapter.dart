
import 'dart:async';

import 'package:example/core/const/mock_data.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [ViewConsumeAdapter] Mock for async view consume simulation.
final class ViewConsumeAdapter implements TWSViewConsumeAdapter{
  const ViewConsumeAdapter();
  
  @override
  Future<List<SetViewOut<Feature>>> consume(int page, int range, List<SetViewOrderOptions> orderings, String input) async {
    late SetViewOut<Feature> setviewMock;
    
    /// Simulating waiting time
    await Future<void>.delayed(Duration(seconds: 1));

    /// Raw data
    List<Feature> records = mockFeatures;

    /// Filtering query
    late List<Feature> filtered;
    if(input.trim().isNotEmpty){
      filtered = records.where((Feature f) {
        return f.name.toLowerCase().contains(input.trim().toLowerCase());
      }).toList();
    }else{
      filtered = records;
    }

    
    setviewMock = SetViewOut<Feature>(
        filtered,
        page,
        DateTime.now(),
        1,
        15,
        15,
      );

    return <SetViewOut<Feature>>[setviewMock];
  }
}