import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:localstorage/localstorage.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// {Storage} implementation.
///
/// Implementaion for an {Storage} manager with {Session} context, it handles operations related with the [ServerSession] application context management.
final class SessionStorage {
  /// Token value storage access key.
  static const String _tokenKey = 'twsg_session_token';

  /// Expiration value storage access key.
  static const String _expirationKey = 'twsg_session_expiration';

  /// Console handler object for logging prints.
  static const Console _console = Console('session_storage');

  DateTime? _expiration;
  DateTime? get expiration => _expiration;

  /// Stores the current server session token.
  String? _token;
  String? get sessionToken => _token;

  /// Whether the application context has an active session.
  bool get isAuth => _validateExpiration(_expiration);

  /// Creates a new [SessionStorage] instance.
  SessionStorage() {
    WidgetsFlutterBinding.ensureInitialized();
    _console.message('Starting [SessionStorage]');
  }

  /// Initializes the storage data and its channel with platform storaging system.
  Future<void> init() async {
    await initLocalStorage();

    String? tokenValue = localStorage.getItem(_tokenKey);
    String? expirationValue = localStorage.getItem(_expirationKey);
    if (tokenValue == null || expirationValue == null) {
      return;
    }

    _token = tokenValue;
    _expiration = DateTime.parse(expirationValue).toLocal();
  }

  /// Validates if the given [expiration] is into the time threshold and it's considered valid.
  static bool _validateExpiration(DateTime? expiration) {
    if (expiration == null) return false;

    DateTime now = DateTime.now();
    DateTime expLocal = expiration.toLocal();

    return now.isBefore(expLocal);
  }

  /// Stores the given [sessionData] into the current [SessionStorage] handling context and preservers it for future requests.
  void store(SessionData sessionData) {
    _token = sessionData.token;
    _expiration = sessionData.expiration;

    if (_token == null || _expiration == null) {
      throw 'Can\'t save [serverSession] if the token or expiration is null';
    }

    localStorage.setItem(_tokenKey, _token!);
    localStorage.setItem(_expirationKey, _expiration!.toIso8601String());
  }

  /// Gets the current user server session authentication token.
  String get() {
    if (_token == null || !isAuth) {
      final Router router = Injector.get();

      router.go(FoundationRoutes.authRoute);
      throw 'Invalid token or has expired, removing session and redirecting to authenticate';
    }

    return _token!;
  }

  /// Clears all the preserve session from the storage.
  void clear() {
    localStorage.removeItem(_tokenKey);
    localStorage.removeItem(_expirationKey);
    _token = null;
    _expiration = null;
  }
}
