import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:localstorage/localstorage.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';
import 'package:tws_foundation_view/src/core/routes.dart';

/// Represents a view solution session persistance and management storage object, provides several
/// operations to handle, communicate and interact with user authentication information contexts.
abstract interface class SessionStorageI {
  /// Gets the current server session token validated and safe.
  String get token;

  /// Initializes the storage data and its channel with platform storaging system.
  Future<void> init();

  /// Stores the given [sessionData] into the current [SessionStorage] handling context and preservers it for future requests.
  void store(SessionData sessionData);

  /// Clears all the preserve session from the storage.
  void clear();

  /// Creates a new [SessionStorageI] instance.
  const SessionStorageI();
}

/// Storage implementation that provides authentication and solution authentication user context information operations.
final class SessionStorage implements SessionStorageI {
  /// Console handler object for logging prints.
  static const Console _console = Console('session_storage');

  /// Token value storage access key.
  static const String _tokenKey = 'twsg_session_token';

  /// Expiration value storage access key.
  static const String _expirationKey = 'twsg_session_expiration';

  /// {int} [_token] stored expiration time mark.
  DateTime? _expiration;

  /// {int} server session token identifier.
  String? _token;

  /// {contact} local user contact data.
  Contact? _contact;

  /// {int} whether logging is enabled.
  final bool _logsOn;

  /// Creates a new [SessionStorage] instance.
  SessionStorage([this._logsOn = false]) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  //! --> Public Members

  /// Gets the current contact information stored in the session.
  Contact? get contact => _contact;

  /// Gets the [rawToken] stored expiration time mark.
  DateTime? get expiration => _expiration;

  /// Gets the current session token value.
  String? get rawToken => _token;

  /// Whether the current user session stills active.
  bool get isActive => _validateExpiration(_expiration);

  @override
  String get token {
    if (_token == null || !isActive) {
      final Router router = Injector.get();

      router.go(FoundationRoutes.authRoute);
      throw 'Invalid token or has expired, removing session and redirecting to authenticate';
    }

    return _token!;
  }

  @override
  Future<void> init() async {
    if (_logsOn) _console.message('Initializing [SessionStorage @($hashCode)]');
    await initLocalStorage();

    String? tokenValue = localStorage.getItem(_tokenKey);
    String? expirationValue = localStorage.getItem(_expirationKey);
    if (tokenValue == null || expirationValue == null) {
      return;
    }

    _token = tokenValue;
    _expiration = DateTime.parse(expirationValue).toLocal();

    if (_logsOn) {
      _console.success(
        '[SessionStorage @($hashCode)] ready.',
        info: <String, dynamic>{
          '_token': _token,
          '_expiration': _expiration,
        },
      );
    }
  }

  @override
  void store(SessionData sessionData) {
    _token = sessionData.token;
    _expiration = sessionData.expiration;
    _contact = sessionData.contact;

    if (_token == null || _expiration == null) {
      throw 'Can\'t save [serverSession] if the token or expiration is null';
    }

    localStorage.setItem(_tokenKey, _token!);
    localStorage.setItem(_expirationKey, _expiration!.toIso8601String());
  }

  @override
  void clear() {
    localStorage.removeItem(_tokenKey);
    localStorage.removeItem(_expirationKey);
    _token = null;
    _expiration = null;
    _contact = null;
  }

  //! <-- Public Members

  /// Validates if the given [expiration] is into the time threshold and it's considered valid.
  static bool _validateExpiration(DateTime? expiration) {
    if (expiration == null) return false;

    DateTime now = DateTime.now();
    DateTime expLocal = expiration.toLocal();

    return now.isBefore(expLocal);
  }
}
