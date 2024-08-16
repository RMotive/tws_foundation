import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class Plate implements CSMSetInterface {
  @override
  int id;
  final String identifier;
  final String state;
  final String country;
  final DateTime expiration;
  final int truck;
  final Truck? truckNavigation;

  Plate(this.id, this.identifier, this.state, this.country, this.expiration, this.truck, this.truckNavigation);
  factory Plate.des(JObject json) {
    Truck? truckNavigation;
    if (json['TruckNavigation'] != null) {
      truckNavigation = deserealize<Truck>(json['TruckNavigation'], decode: TruckDecoder());
    }
    int id = json.get('id');
    String identifier = json.get('identifier');
    String state = json.get('state');
    String country = json.get('country');
    DateTime expiration = json.get("expiration");
    int truck = json.get('truck');
    return Plate(id, identifier, state, country, expiration, truck, truckNavigation);
  }

  @override
  JObject encode() {
    String exp = expiration.toString().substring(0, 10);
    return <String, dynamic>{'id': id, 'identifier': identifier, 'state': state, 'country': country, 'expiration': exp, 'truck': truck, 'truckNavigation': truckNavigation?.encode()};
  }

  @override
  List<CSMSetValidationResult> evaluate() {
    // TODO: implement evaluate
    throw UnimplementedError();
  }
}

final class PlateDecoder implements CSMDecodeInterface<Plate> {
  const PlateDecoder();

  @override
  Plate decode(JObject json) {
    return Plate.des(json);
  }
}
