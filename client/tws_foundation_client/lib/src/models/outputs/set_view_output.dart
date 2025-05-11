import 'package:csm_client/csm_client.dart';

/// Defines the mirror class to store a [SetViewOutput] result,
/// describing the behavior of a paged table returning data for the required size of pages and page.
///
///
/// [TSet] : The type of live database mirror set from to build the [View].
final class SetViewOutput<TSet extends EntityB<TSet>> implements EncodableI, DecodableI {
  /// Records resolved.
  List<TSet> records;

  /// Total amount of pages available.
  int pages;

  /// The current page resulted.
  int page;

  /// Timemark where this view resolution was created.
  DateTime creation;

  /// The quantity of records resolved.
  int length;

  /// The total quantity of available records at the data storage.
  int count;

  /// Creates a new [SetViewOutput] object.
  SetViewOutput(this.records, this.page, this.creation, this.pages, this.length, this.count);

  @override
  DataMap encode() {
    return <String, dynamic>{
      'records': records.map((TSet e) => e.encode()).toList(),
      'pages': pages,
      'page': page,
      'creation': creation.toString(),
      'length': length,
      'count': count,
    };
  }
  
  @override
  void decode(DataMap encode) {
    records = encode.getList('records');
    pages = encode.get('pages');
    page = encode.get('page');
    creation = encode.get('creation');
    length = encode.get('lenght');
    count = encode.get('count');
  }
}
