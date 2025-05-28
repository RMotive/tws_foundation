import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/constants.dart';
import 'package:tws_foundation_client/src/core/entity_utilities.dart';
import 'package:tws_foundation_client/src/entities/business/approach.dart';
import 'package:tws_foundation_client/src/entities/business/identification.dart';
import 'package:tws_foundation_client/src/entities/business/status.dart';
import 'package:tws_foundation_client/src/services/business/addresses/address.dart';
import 'package:tws_foundation_client/src/services/business/employees/employee_dates.dart';

/// [Employee] default builder.
Employee employeeBuilder() => Employee();

/// Defines a business entity that stores the personal data for each [Employee] in TWS operations.
final class Employee extends EntityB<Employee> {
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
  Identification identification = Identification();

  /// [Status] set navigation.
  Status status = Status();

  /// [EmployeeDates]/Contact set navigation.
  EmployeeDates dates = EmployeeDates();

  /// [Address] set navigation.
  Address? address;

  /// [Approach]/Contact set navigation.
  Approach? approach;


  /// Generates a new [Employee] instance from mandatory values.
  Employee();
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
        <String, Object?>{
          kCurp: curp,
          kRfc: rfc,
          kNss: nss,
          kIdentification: identification.encode(),
          EntitiesCommonProperties.kStatus: status.encode(),
          kAddress: address?.encode(),
          kApproach: approach?.encode(),
          kEmployeeDates: dates.encode(),
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
      status.decode(
          encode.get(EntitiesCommonProperties.kStatus, <String, dynamic>{}));
    }

    if(encode[kIdentification] != null){
      identification = Identification();
      identification.decode(
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
      dates.decode(
          encode.get(kEmployeeDates, <String, dynamic>{}));
    }
  }

  @override
  List<EntityInvalidation<Employee>> evaluate() {
    List<EntityInvalidation<Employee>> results = <EntityInvalidation<Employee>>[];
    if (id < BigInt.zero) results.add(EntityInvalidation<Employee>(this, PropertyInfo(EntityKeys.id, int, id), 'Pointer cannot be less than 0', 'invalidPointer()'));

    if(curp != null){
      if(curp!.length != 18) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kCurp, String, curp), "CURP number must be 18 length", "strictLength(18)"));
    }

    if(rfc != null){
      if(rfc!.length != 12) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kRfc, String, rfc), "CURP number must be 18 length", "strictLength(12)"));
    }

    if(nss != null){
      if(nss!.length != 11) results.add(EntityInvalidation<Employee>(this, PropertyInfo(kNss, String, nss), "The NSS number must be 11 character length", "structLength(11)"));
    }
    
    results.validateDependency(this, status);
    results.validateDependency(this, dates);
    results.validateDependency(this, identification);
    if(address != null) results.validateDependency(this, address!);
    if(approach != null) results.validateDependency(this, approach!);

    return results;
  }

}
