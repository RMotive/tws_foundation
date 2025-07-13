import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [TrucksServiceI] implementation, wich is responsible to manage operations
/// related with [TruckCommon] entity at {Foundation Server}.
abstract interface class TrucksServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<TruckCommon> {
  /// Creates a new [TrucksServiceI] instance.
  TrucksServiceI(super.host, super.servicePath);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [TrucksServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class TruckServiceB extends FoundationServiceB implements TrucksServiceI {
  /// Creates a new [TruckServiceB] instance.
  TruckServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [TruckService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [TruckCommon] based operations.
final class TruckService extends TruckServiceB {
  /// Creates a new [DriversService] instance.
  TruckService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'trucks',
        );

  @override
  FoundationFutureResolver<ViewOutput<TruckCommon>> view(ViewInput<TruckCommon> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<TruckCommon>>(
      await postSecure<ViewInput<TruckCommon>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }
}
