part of 'auth_page.dart';

/// {Page} implementation.
///
/// Composes a complex {CSM} business login page based on different authentiation options for different {Solutions}.
final class _AuthPageForm extends StatefulWidget {
  /// Solution authentication scope sign identification.
  final String solutionSign;

  /// Callback when the [AuthPage] correctly authenticates the user information.
  ///
  ///
  /// [SessionData] server session information from the given credentials.
  final FutureOr<void> Function(SessionData sessionData) onAuthSuccess;

  /// Creates a new [_AuthPageForm] instance.
  const _AuthPageForm({required this.solutionSign, required this.onAuthSuccess});

  @override
  State<_AuthPageForm> createState() => _AuthPageFormState();
}

/// [State] implementation.
///
/// Hanles the state management from [_AuthPageForm] and how it's being drawn.
final class _AuthPageFormState extends State<_AuthPageForm> {
  /// Specifies the max amount of width that all controls in the form will take.
  static const double _maxInputsWidth = 275;

  /// Access to the inner [Form] widget state.
  final GlobalKey<FormState> _formStateKey = GlobalKey();

  /// Security service dependency access.
  final SecurityServiceI securityService = Injector.get();

  /// Whether the widget is in loading mode, fetching data from services.
  bool isLoading = false;

  /// Current error message.
  String errorMsg = '';

  /// User/Identity value.
  String usrValue = '';

  /// Password value.
  String pwdValue = '';

  /// Current identity scope error message.
  String? usrErrorMsg;

  /// Current password scope error message.
  String? pwdErrorMsg;

  /// Validates the inners [TextInput] values.
  ///
  /// This validation is not specific by property scope, is a general shared validations along both inner [TextInput].
  String? validateTextInput(String? currentInputValue) {
    currentInputValue ??= "";

    if (currentInputValue.isEmpty) {
      return FoundationMessages.emptyInputError;
    }

    return null;
  }

  /// Cleans all the current error messages states.
  void cleanState() {
    errorMsg = '';
    usrErrorMsg = null;
    pwdErrorMsg = null;
  }

  /// {event} method when inner [ButtonFlat] is clicked, invoking the authentication process and validations.
  Future<void> authenticate() async {
    cleanState();
    final bool? fomrValidateResult = _formStateKey.currentState?.validate();
    if (fomrValidateResult == null) {
      setState(() {
        errorMsg = FoundationMessages.stateManagementError;
      });
      return;
    }
    if (!fomrValidateResult) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final FoundationResponseResolver<SessionData> authResolver = await securityService.authenticate(
      AuthenticationInput.a(widget.solutionSign, usrValue, pwdValue.bytes),
    );

    authResolver.resolve(
      objectBuilder: () => SessionData(),
      onSuccess: (SuccessFrame<SessionData> success) => widget.onAuthSuccess(success.content),
      onFailure: (FailureFrame failure, int status) {
        if (status != 401) {
          errorMsg = FoundationMessages.unknownServerException;
          return;
        }

        final ExceptionInfo exInfo = failure.content;
        switch (exInfo.situation) {
          case 0:
            usrErrorMsg = exInfo.advise;
          case 1:
            pwdErrorMsg = exInfo.advise;
          default:
            errorMsg = FoundationMessages.unknownServerException;
        }
      },
      onException: (TracedException exception) {
        errorMsg = FoundationMessages.unknownServerException;
      },
      onConnectionFailure: () {
        errorMsg = FoundationMessages.connectionError;
      },
      onFinally: () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formStateKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24,
          children: <Widget>[
            Visibility(
              visible: errorMsg.isNotEmpty,
              child: TWSDisplayFlat(width: _maxInputsWidth - 25, maxHeight: 100, display: errorMsg),
            ),
            TextInput(
              label: 'Identity',
              hint: 'Your solution identity',
              autofillHints: <String>[AutofillHints.username, AutofillHints.email],
              errorText: usrErrorMsg,
              width: _maxInputsWidth,
              isEnabled: !isLoading,
              onChanged: (String text) => usrValue = text,
              validator: validateTextInput,
            ),
            TextInput(
              label: 'Password',
              hint: 'Your secret word',
              isPrivate: true,
              autofillHints: <String>[AutofillHints.password],
              errorText: pwdErrorMsg,
              width: _maxInputsWidth,
              isEnabled: !isLoading,
              onChanged: (String text) => pwdValue = text,
              validator: validateTextInput,
            ),
            ButtonFlat(width: _maxInputsWidth, onClick: authenticate),
          ],
        ),
      ),
    );
  }
}
