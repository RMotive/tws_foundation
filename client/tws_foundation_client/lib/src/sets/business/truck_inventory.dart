import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TruckInventory implements CSMSetInterface {
   /// [entryDate] property key.
  static const String kEntryDate = "entryDate";

  /// [section] property key.
  static const String kSection = "section";

  /// [truck] property key.
  static const String kTruck = "truck";

  /// [truckExternal] property key.
  static const String kTruckExternal = "truckExternal";

  /// [truckNavigation] property key.
  static const String kTruckNavigation = "TruckNavigation";

  /// [truckExternalNavigation] property key.
  static const String kTruckExternalNavigation = "TruckExternalNavigation";

    /// [sectionNavigation] property key.
  static const String kSectionNavigation = "SectionNavigation";

  late final DateTime _timestamp;
  DateTime get timestamp => _timestamp; 

  /// Record database pointer.
  @override
  int id = 0;

  /// Inventory register date.
  DateTime entryDate = DateTime(0);

  /// section where the truck is parked.
  int section = 0;

  /// truck pointer.
  int? truck;

  /// truck extenral pointer.
  int? truckExternal;

  /// truck set navigator.
  Truck? truckNavigation;

  /// truck external navigator.
  TruckExternal? truckExternalNavigation;

  /// section navigator.
  Section? sectionNavigation;

  /// Creates an [TruckInventory] object with required properties
  TruckInventory(this.id, this.entryDate, this.section, this.truck, this.truckExternal, this.truckNavigation, this.truckExternalNavigation, this.sectionNavigation, { 
    DateTime? timestamp,
  }){
    _timestamp = timestamp ?? DateTime.now(); 
  }

  /// Creates an [TruckInventory] based on a [json] object.
  factory TruckInventory.des(JObject json) {
    int id = json.get(SCK.kId);
    DateTime timestamp = json.get(SCK.kTimestamp);
    DateTime entryDate = json.get(kEntryDate);
    int section = json.get(kSection);
    int? truck = json.getDefault(kTruck, null);
    int? truckExternal = json.getDefault(kTruckExternal, null);

    Truck? truckNavigation;
    if (json[kTruckNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTruckNavigation, <String, dynamic>{});
      truckNavigation = Truck.des(rawNavigation);
    }

    TruckExternal? truckExternalNavigation;
    if (json[kTruckExternalNavigation] != null) {
      JObject rawNavigation = json.getDefault(kTruckExternalNavigation, <String, dynamic>{});
      truckExternalNavigation = TruckExternal.des(rawNavigation);
    }

    Section? sectionNavigation;
    if (json[kSectionNavigation] != null) {
      JObject rawNavigation = json.getDefault(kSectionNavigation, <String, dynamic>{});
      sectionNavigation = Section.des(rawNavigation);
    }
    
    return TruckInventory(id, entryDate, section, truck, truckExternal, truckNavigation, truckExternalNavigation, sectionNavigation, timestamp: timestamp);
  }

  /// Creates an [TruckInventory] overriding the given properties.
  @override
  JObject encode() {
    return <String, dynamic>{
      SCK.kId: id,
      kEntryDate: entryDate,
      kSection: section,
      kTruck: truck,
      kTruckExternal: truckExternal,
      kTruckNavigation: truckNavigation?.encode(),
      kTruckExternalNavigation: truckExternalNavigation?.encode(),
      kSectionNavigation: sectionNavigation?.encode(),
      SCK.kTimestamp: timestamp.toIso8601String(),
    };
  }
  
  @override
  List<CSMSetValidationResult> evaluate() {
    List<CSMSetValidationResult> results = <CSMSetValidationResult>[];
    return results;
  }
  TruckInventory.a();

  TruckInventory clone({
    int? id,
    DateTime? entryDate,
    int? section,
    int? truck,
    int? truckExternal,
    Truck? truckNavigation,
    TruckExternal? truckExternalNavigation,
    Section? sectionNavigation,
  }){
    return TruckInventory(
      id ?? this.id,
      entryDate ?? this.entryDate,
      section ?? this.section,
      truck ?? this.truck,
      truckExternal ?? this.truckExternal,
      truckNavigation ?? this.truckNavigation,
      truckExternalNavigation ?? this.truckExternalNavigation,
      sectionNavigation ?? this.sectionNavigation,
    );
  }
  
}