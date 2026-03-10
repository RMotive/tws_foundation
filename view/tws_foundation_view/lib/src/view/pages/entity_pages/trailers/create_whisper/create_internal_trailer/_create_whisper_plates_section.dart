part of '../trailers_page_create_whisper.dart';

/// Address state class.
class _PlateState extends ReactorBase {}

_PlateState _plateState = _PlateState();
void Function() _plateEffect = () {};

class _CreateWhisperPlatesSection extends StatelessWidget {
  // Initial plate data.
  final Plate plate;
  // current plate index.
  final int index;
  // Inputs onChange methods.
  final void Function(String) identifierOnChange;
  final void Function(String?) countryOnChange;
  final void Function(String?) stateOnChange;
  final void Function(String) expirationOnChange;

  const _CreateWhisperPlatesSection({
    required this.plate,
    required this.identifierOnChange,
    required this.countryOnChange,
    required this.stateOnChange,
    required this.expirationOnChange,
    required this.index,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SectionDivider(text: 'Plate $index'),
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: '*Identifier',
                maxLength: 12,
                controller: TextEditingController(text: plate.identifier),
                onChanged: identifierOnChange,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AutoCompleteField<String>(
                  nativeList: _countries,
                  initialValue: plate.country == "" ? null : plate.country,
                  displayValue: (String? item) => item ?? "Invalid data",
                  label: '*Country',
                  onChanged: countryOnChange,
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: <Widget>[
            ReactiveWidget<_PlateState>(
              reactor: _plateState,
              builder: (BuildContext ctx, _PlateState state) {
                final String currentCountry = plate.country;
                _plateEffect = state.react;
                return Expanded(
                  child: AutoCompleteField<String>(
                    isEnabled: !currentCountry.dirtyString,
                    nativeList: currentCountry == _countries[0] ? _statesUSA : _statesMX,
                    initialValue: plate.state == "" ? null :  plate.state,
                    displayValue:(String? item) => item ?? "Not valid data",
                    label: '*$currentCountry State',
                    isOptional: true,
                    onChanged: stateOnChange,
                  ),
                );
              },
            ),
            Expanded(
              child: Datepicker(
                firstDate: DateTime(1999),
                lastDate: DateTime.now(),
                label: 'Expiration Date',
                controller: TextEditingController(text: plate.expiration?.dateOnly),
                onChanged: expirationOnChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}