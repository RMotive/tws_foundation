import 'package:csm_foundation_services/csm_foundation_services.dart';

/// Defines the mirror class to store a [MigrationView] result,
/// describing the behavior of a paged table returning data for the required size of pages and page.
///
///
/// [TSet] : The type of live database mirror set from to build the [View].
final class MigrationView<TSet extends CSMEncodeInterface> implements CSMEncodeInterface {
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

  /// Creates a new [MigrationView] object.
  const MigrationView(this.sets, this.page, this.creation, this.pages, this.records, this.amount);

  /// Creates a new [MigrationView] object based on deserealization from a [JObject].
  ///
  /// [json] : The object to bind properties.
  /// [setDecode] : Optional [CSMDecodeInterface] implementation to use on environment cases.
  factory MigrationView.des(
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

    return MigrationView<TSet>(setsObjects, page, creation, pages, records, amount);
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

/// [CSMDecodeInterface] implementation from [MigrationView] represents the deserealization
/// convention and operation to convert a [JObject] into a [MigrationView].
final class MigrationViewDecode<TSet extends CSMEncodeInterface> implements CSMDecodeInterface<MigrationView<TSet>> {
  /// Required [CSMDecodeInterface] implementation for the inner generic type [TSet] from [MigrationView].
  final CSMDecodeInterface<TSet> setDecoder;

  /// Creates a new [MigrationViewDecode] object.
  const MigrationViewDecode(this.setDecoder);

  @override
  MigrationView<TSet> decode(JObject json) {
    return MigrationView<TSet>.des(json, setDecode: setDecoder);
  }
}
