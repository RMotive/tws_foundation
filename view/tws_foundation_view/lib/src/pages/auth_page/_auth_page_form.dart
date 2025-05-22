part of 'auth_page.dart';

///
final class _AuthPageForm extends StatelessWidget {
  ///
  const _AuthPageForm();

  @override
  Widget build(BuildContext context) {
    final _AuthPageFormReactor reactor = _AuthPageFormReactor();

    return ReactiveWidget<_AuthPageFormReactor>(
      reactor: reactor,
      builder: (BuildContext ctx, _AuthPageFormReactor state) {
        return Form(
          key: state.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 24,
            children: <Widget>[
              Visibility(
                visible: state.failureDisplay.isNotEmpty,
                child: TWSDisplayFlat(
                  width: state.maxControlsWidth - 25,
                  maxHeight: 100,
                  display: state.failureDisplay,
                ),
              ),
              TextInput(
                label: 'Identity',
                hint: 'Your solution identity 🧑‍⚕️',
                errorText: state.identityFailure,
                width: state.maxControlsWidth,
                isEnabled: !state.isRequesting,
                validator: state.validateIdentityInput,
              ),
              TextInput(
                label: 'Password',
                hint: 'Your secret word 🔐',
                isPrivate: true,
                errorText: state.passwordFailure,
                width: state.maxControlsWidth,
                isEnabled: !state.isRequesting,
                validator: state.validatePasswordInput,
              ),
              ButtonFlat(
                width: state.maxControlsWidth,
                onTap: state.initSession,
              ),
            ],
          ),
        );
      },
    );
  }
}
