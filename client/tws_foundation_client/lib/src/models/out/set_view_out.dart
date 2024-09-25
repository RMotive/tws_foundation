import 'package:csm_foundation_services/csm_foundation_services.dart';

/// Defines the mirror class to store a [SetViewOut] result,
/// describing the behavior of a paged table returning data for the required size of pages and page.
///
///
/// [TSet] : The type of live database mirror set from to build the [View].
final class SetViewOut<TSet extends CSMEncodeInterface> implements CSMEncodeInterface {
  /// Records resolved.
  final List<TSet> sets;

  /// Total amount of pages available.
  final int pages;

  /// The current page resulted.
  final int page;

  /// Timemark where this view resolution was created.
  final DateTime creation;

  /// The quantity of records resolved.
  final int records;

  /// The total quantity of available records at the live database.
  final int amount;

  /// Creates a new [SetViewOut] object.
  const SetViewOut(this.sets, this.page, this.creation, this.pages, this.records, this.amount);

  /// Creates a new [SetViewOut] object based on deserealization from a [JObject].
  ///
  /// [json] : The object to bind properties.
  /// [setDecode] : Optional [CSMDecodeInterface] implementation to use on environment cases.
  factory SetViewOut.des(
    JObject json, {
    CSMDecodeInterface<TSet>? setDecode,
  }) {
    List<JObject> rawSetsArray = json.getDefault('sets', <dynamic>[]).cast();
    List<TSet> setsObjects = rawSetsArray
        .map<TSet>((JObject e) => deserealize(
              e,
              decode: setDecode,
            ))
        .toList();

    int pages = json.get('pages');
    int page = json.get('page');
    int records = json.get('records');
    int amount = json.get('amount');

    DateTime creation = json.get('creation');

    return SetViewOut<TSet>(setsObjects, page, creation, pages, records, amount);
  }

  @override
  JObject encode() {
    return <String, dynamic>{
      'sets': sets.map((TSet e) => e.encode()).toList(),
      'pages': pages,
      'page': page,
      'creation': creation.toString(),
      'records': records,
      'amount': amount,
    };
  }
}

/// [CSMDecodeInterface] implementation from [SetViewOut] represents the deserealization
/// convention and operation to convert a [JObject] into a [SetViewOut].
final class SetViewOutDecode<TSet extends CSMEncodeInterface> implements CSMDecodeInterface<SetViewOut<TSet>> {
  /// Required [CSMDecodeInterface] implementation for the inner generic type [TSet] from [SetViewOut].
  final CSMDecodeInterface<TSet> setDecoder;

  /// Creates a new [SetViewOutDecode] object.
  const SetViewOutDecode(this.setDecoder);

  @override
  SetViewOut<TSet> decode(JObject json) {
    return SetViewOut<TSet>.des(json, setDecode: setDecoder);
  }
}
