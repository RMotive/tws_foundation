import 'package:csm_client/csm_client.dart';

/// Defines the mirror class to store a [SetViewOut] result,
/// describing the behavior of a paged table returning data for the required size of pages and page.
///
///
/// [TSet] : The type of live database mirror set from to build the [View].
final class SetViewOut<TSet extends CSMEncodeInterface> implements CSMEncodeInterface {
  /// Records resolved.
  final List<TSet> records;

  /// Total amount of pages available.
  final int pages;

  /// The current page resulted.
  final int page;

  /// Timemark where this view resolution was created.
  final DateTime creation;

  /// The quantity of records resolved.
  final int length;

  /// The total quantity of available records at the data storage.
  final int count;

  /// Creates a new [SetViewOut] object.
  const SetViewOut(this.records, this.page, this.creation, this.pages, this.length, this.count);

  /// Creates a new [SetViewOut] object based on deserealization from a [JObject].
  ///
  /// [json] : The object to bind properties.
  /// [setDecode] : Optional [CSMDecodeInterface] implementation to use on environment cases.
  factory SetViewOut.des(JObject json, TSet Function(JObject json) decoder) {

    List<JObject> rawRecords = json.getDefault('records', <dynamic>[]).cast();
    List<TSet> records = rawRecords
        .map<TSet>(decoder)
        .toList();

    int pages = json.get('pages');
    int page = json.get('page');
    int length = json.get('length');
    int count = json.get('count');

    DateTime creation = json.get('creation');

    return SetViewOut<TSet>(records, page, creation, pages, length, count);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'records': records.map((TSet e) => e.encode()).toList(),
      'pages': pages,
      'page': page,
      'creation': creation.toString(),
      'length': length,
      'count': count,
    };
  }
}
