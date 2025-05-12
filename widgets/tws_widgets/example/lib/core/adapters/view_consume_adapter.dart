
import 'dart:async';

import 'package:example/core/const/mock_data.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';


/// [ViewConsumeAdapter] Mock for async view consume simulation.
final class ViewConsumeAdapter implements TWSViewConsumeAdapter{
  const ViewConsumeAdapter();
  
  @override
  Future<List<SetViewOutput<TrailerClass>>> consume(int page, int range, List<SetViewOutput<dynamic>> orderings, String input) async {
    late SetViewOutput<TrailerClass> setviewMock;
    
    /// Simulating waiting time
    await Future<void>.delayed(Duration(seconds: 1));

    /// Raw data
    List<TrailerClass> records = mockFeatures;

    /// Filtering query
    late List<TrailerClass> filtered;
    if(input.trim().isNotEmpty){
      filtered = records.where((TrailerClass f) {
        return f.name.toLowerCase().contains(input.trim().toLowerCase());
      }).toList();
    }else{
      filtered = records;
    }

    
    setviewMock = SetViewOutput<TrailerClass>(
        filtered,
        page,
        DateTime.now(),
        1,
        15,
        15,
      );

    return <SetViewOutput<TrailerClass>>[setviewMock];
  }
}