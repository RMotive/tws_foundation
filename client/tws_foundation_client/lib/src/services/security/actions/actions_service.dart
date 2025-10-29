import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Represents a contract for a [ActionsServiceI] implementation, wich is responsible to manage operations
/// related with [Action] entity at {Foundation Server}.
abstract interface class ActionsServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Action>{
  /// Creates a new [ActionsServiceI] instance.
  ActionsServiceI(super.host, super.servicePath);
}

/// {abstract} class.
///
/// Represents a base behavior implementation for a [ActionsServiceI] implementation, providing shared default
/// behavior along built-in native and custom outside implementations.
abstract class ActionsServiceB extends FoundationServiceB implements ActionsServiceI {
  /// Creates a new [ContactsServiceB] instance.
  ActionsServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// {Foundation Client} built-in native implementation for [ActionsService], provides standard operations and communication with
/// foundation server to call and operate with this service and handle [Action] based operations.
final class ActionsService extends ActionsServiceB {
  /// Creates a new [ActionsService] instance.
  ActionsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'actions',
        );

  @override
  FoundationFutureResolver<ViewOutput<Action>> view(ViewInput<Action> input, String auth) async {
    return FoundationResponseResolver<ViewOutput<Action>>(
      await postSecure<ViewInput<Action>>(
        'view',
        input,
        authToken: auth,
      ),
    );
  }
}
