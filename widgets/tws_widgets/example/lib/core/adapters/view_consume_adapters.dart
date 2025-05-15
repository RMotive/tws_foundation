
import 'dart:async';

import 'package:example/core/const/mock_data.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_widgets/tws_widgets.dart';

/// [ViewConsumeAdapter] Mock for async view consume simulation.
final class ViewConsumeAdapter implements TWSViewConsumeAdapter{
  const ViewConsumeAdapter();
  
  @override
  Future<List<ViewOutput<TrailerClass>>> consume(int page, int range, String input) async {
    late ViewOutput<TrailerClass> setviewMock;
    
    /// Simulating waiting time
    await Future<void>.delayed(Duration(seconds: 1));

    /// Raw data
    List<TrailerClass> records = mockTrailerClasses;

    /// Filtering query
    late List<TrailerClass> filtered;
    if(input.trim().isNotEmpty){
      filtered = records.where((TrailerClass f) {
        return f.name.toLowerCase().contains(input.trim().toLowerCase());
      }).toList();
    }else{
      filtered = records;
    }

    setviewMock = ViewOutput<TrailerClass>(() => TrailerClass());
    setviewMock.page = 1;
    setviewMock.pages = 1;
    setviewMock.length = 15;
    setviewMock.count = 15;
    setviewMock.timestamp = DateTime.now();
    setviewMock.entities = filtered;

    return <ViewOutput<TrailerClass>>[setviewMock];
  }
}

/// [ViewMultiConsumeAdapter] Mock for async view consume simulation.
final class ViewMultiConsumeAdapter implements TWSViewConsumeAdapter{
  const ViewMultiConsumeAdapter();
  
  @override
  Future<List<ViewOutput<dynamic>>> consume(int page, int range, String input) async {
    late ViewOutput<TrailerClass> trailersClassMock;
    late ViewOutput<Loadtype> loadTypeMock;

    /// Simulating waiting time (getting the views consume data)
    await Future<void>.delayed(Duration(seconds: 1));
    
    trailersClassMock = ViewOutput<TrailerClass>(() => TrailerClass());
    trailersClassMock.page = 1;
    trailersClassMock.pages = 1;
    trailersClassMock.length = 15;
    trailersClassMock.count = 15;
    trailersClassMock.timestamp = DateTime.now();
    trailersClassMock.entities = mockTrailerClasses;

    loadTypeMock = ViewOutput<Loadtype>(() => Loadtype());
    loadTypeMock.page = 1;
    loadTypeMock.pages = 1;
    loadTypeMock.length = 15;
    loadTypeMock.count = 15;
    loadTypeMock.timestamp = DateTime.now();
    loadTypeMock.entities = mockloadstypes;

    /// Adding multiple Entitie view types in a dynamic list.
    List<ViewOutput<dynamic>> mixedView = <ViewOutput<dynamic>>[trailersClassMock, loadTypeMock];

    return mixedView;
  }
}