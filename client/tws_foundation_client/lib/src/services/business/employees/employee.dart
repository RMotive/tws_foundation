import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/entities/business/approach.dart';
import 'package:tws_foundation_client/src/entities/business/identification.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/services/business/addresses/address.dart';
import 'package:tws_foundation_client/src/services/business/employees/employee_dates.dart';

final class Employee extends NamedEntityB<Employee> {
  /// [curp] property key.
  static const String kCurp = "curp";

  /// [rfc] property key.
  static const String kRfc = "rfc";

  /// [nss] property key.
  static const String kNss = "nss";

  /// [identification] property key.
  static const String kIdentification = "identification";

  /// [Address] property key.
  static const String kAddress = "address";
  
  /// [Approach] property key.
  static const String kApproach = "approach";

  /// [Driver] property key.
  static const String kDriver = "driver";

  /// [Status] property key.
  static const String kStatus = "status";

  /// [nss] property key.
  static const String kEmployeeDates = "dates";

  /// 18 lenght CURP number.
  String? curp;

  /// 12 lenght RFC number.
  String? rfc;

  /// 11 lenght Mexican Social Asurance Number (NSS). 
  String? nss;
  
  /// [Identification] set navigation.
  Identification? identification;

  /// [Status] set navigation.
  Status? status;

  /// [Address] set navigation.
  Address? address;

  /// [Approach]/Contact set navigation.
  Approach? approach;

  /// [EmployeeDates]/Contact set navigation.
  EmployeeDates? dates;

  /// Generates a new [Employee] instance from mandatory values.
  Employee();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kCurp: curp,
          kRfc: rfc,
          kNss: nss,
          kIdentification: identification?.encode(),
          EntitiesCommonProperties.kStatus: status?.encode(),
          kAddress: address?.encode(),
          kApproach: approach?.encode(),
          kEmployeeDates: dates?.encode(),
          // TODO add drivers model
      },
    );
  }
  
  @override
  void decode(DataMap encode) {
    super.decode(encode);
    curp = encode.get(kCurp, null);
    rfc = encode.get(kRfc, null);
    nss = encode.get(kNss, null);
    if(encode[EntitiesCommonProperties.kStatus] != null){
      status = Status();
      status!.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }

    if(encode[kIdentification] != null){
      identification = Identification();
      identification!.decode(
          encode.get(kIdentification, <String, dynamic>{}));
    }

    if(encode[kAddress] != null){
      address = Address();
      address!.decode(
          encode.get(kAddress, <String, dynamic>{}));
    }

    if(encode[kApproach] != null){
      approach = Approach();
      approach!.decode(
          encode.get(kApproach, <String, dynamic>{}));
    }

    if(encode[kEmployeeDates] != null){
      dates = EmployeeDates();
      dates!.decode(
          encode.get(kEmployeeDates, <String, dynamic>{}));
    }
  }

  @override
  List<EntityInvalidation<Employee>> evaluate() {
    List<EntityInvalidation<Employee>> results = <EntityInvalidation<Employee>>[];

    if (name.isEmpty) results.add(EntityInvalidation<Employee>(this, PropertyInfo('Name', String, name), 'Name can\'t be empty', 'notEmpty'));
     if(identification == null || (identification != null && identification!.id < BigInt.zero)) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kIdentification, Identification, identification), 'Identification pointer must be equal or greater than 0, or set a navigation', 'pointerHandler()'));
   
    if(address != null){
      if(address!.id < BigInt.zero) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kAddress, Address, address), 'Address pointer must be equal or greater than 0', 'pointerHandler()'));
    }

    if(approach != null){
      if(approach!.id < BigInt.zero) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kApproach, Approach, approach), 'Approach pointer must be equal or greater than 0', 'pointerHandler()'));
    }
    
    if(status == null || ( status != null && status!.id < BigInt.zero)) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kStatus, Status, status), 'Status pointer must be equal or greater than 0', 'pointerHandler()'));

    if(curp != null){
      if(curp!.length != 18) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kCurp, String, curp), "CURP number must be 18 length", "strictLength(18)"));
    }

    if(rfc != null){
      if(rfc!.length != 12) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kRfc, String, rfc), "CURP number must be 18 length", "strictLength(12)"));
    }

    if(nss != null){
      if(nss!.length != 11) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kNss, String, nss), "The NSS number must be 11 character length", "structLength(11)"));
    }

    // if(identificationNavigation != null) results = <CSMSetValidationResult>[...results, ...identificationNavigation!.evaluate()];   
    // if(addressNavigation != null) results = <CSMSetValidationResult>[...results, ...addressNavigation!.evaluate()];   
    // if(approachNavigation != null) results = <CSMSetValidationResult>[...results, ...approachNavigation!.evaluate()];   

    return results;
  }

}
