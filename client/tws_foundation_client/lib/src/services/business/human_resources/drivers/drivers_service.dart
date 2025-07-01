import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Contract for [DriversServiceI] implementations that handles service call operations based on [DriverCommon] entity.
abstract interface class DriversServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<DriverCommon> {
  /// Creates a new [DriversServiceI] instance.
  DriversServiceI(super.host, super.servicePath);
}

/// {abstract} class.
///
/// Implements base behavior for [DriversServiceI] implementations providing shared resources along custom implementations.
abstract class DriversServiceB extends FoundationServiceB implements DriversServiceI {
  /// Creates a new [DriversServiceB] instance.
  DriversServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [DriversServiceI], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [DriverCommon] based operations.
final class DriversService extends DriversServiceB {
  /// Creates a new [DriversService] instance.
  DriversService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'drivers',
        );

  @override
  FoundationFutureResolver<ViewOutput<DriverCommon>> view(ViewInput<DriverCommon> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<DriverCommon>>(
      await postSecure<ViewInput<DriverCommon>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }
}
