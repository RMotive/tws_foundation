part of 'locations_page_create_whisper.dart';

/// Address state class.
class _AddresState extends ReactorBase {}

_AddresState _addresState = _AddresState();
// ignore: unused_element
void Function() _addressEffect = () {};

class _CreateWhisperAddressesSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<Location>? itemState;
  final bool isEnabled;

  const _CreateWhisperAddressesSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> countries = FoundationCollections.kCountryList;
    const List<String> statesUSA = FoundationCollections.kUStateCodes;
    const List<String> statesMX = FoundationCollections.kMXStateCodes;

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// --> Driver Address Information.
        const SectionDivider(
          text: "Address Information",
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: AutoCompleteField<String>(
                isEnabled: isEnabled,
                nativeList: countries,
                initialValue: itemState?.entity.address.country == "" ? null :  itemState?.entity.address.country,
                displayValue:(String? item) => item ?? "Not valid data",
                label: 'Country',
                onChanged: (String? text) {
                  Location location = itemState!.entity;
                  location.address =
                      location.address.sanitize(country: text ?? "") ?? Address().sanitize(country: text) ?? Address();
                  itemState?.react();
                  _addresState.react();
                },
              ),
            ),
            ReactiveWidget<_AddresState>(
              reactor: _addresState,
              builder: (BuildContext ctx, _AddresState state) {
                final String? currentCountry = itemState?.entity.address.country;
                _addressEffect = state.react;
                return AutoCompleteField<String>(
                  isEnabled: currentCountry != null,
                  nativeList: currentCountry == countries[0] ? statesUSA : statesMX,
                  initialValue: itemState?.entity.address.state == "" ? null :  itemState?.entity.address.state,
                  displayValue:(String? item) => item ?? "Not valid data",
                  label: '${currentCountry ?? ''} State',
                  isOptional: true,
                  onChanged: (String? text) {
                    Location location = itemState!.entity;
                    location.address = location.address.sanitize(state: text ?? "") ?? Address().sanitize(state: text) ?? Address();
                    itemState?.react();
                  },
                );
              },
            ),
          ],
        ),

        TextInput(
          width: double.maxFinite,
          deBounce: Duration(milliseconds: 300),
          label: 'City',
          isEnabled: isEnabled,
          maxLength: 30,
          isOptional: true,
          controller: TextEditingController(
            text: itemState?.entity.address.city,
          ),
          onChanged: (String text) {
            Location location = itemState!.entity;
            location.address = location.address.sanitize(city: text) ?? Address().sanitize(city: text) ?? Address();
            itemState?.react();
          },
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Street',
                deBounce: Duration(milliseconds: 300),
                isEnabled: isEnabled,
                maxLength: 100,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.address.street,
                ),
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.address = location.address.sanitize(street: text) ?? Address().sanitize(street: text) ?? Address();
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Alternative Street',
                deBounce: Duration(milliseconds: 300),
                isEnabled: isEnabled,
                maxLength: 100,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.address.altStreet,
                ),
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.address = location.address.sanitize(altStreet: text) ?? Address().sanitize(altStreet: text) ?? Address();
                  itemState?.react();
                },
              ),
            ),
          ],
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'ZIP',
                deBounce: Duration(milliseconds: 300),
                isEnabled: isEnabled,
                maxLength: 5,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.address.zip,
                ),
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.address = location.address.sanitize(zip: text) ?? Address().sanitize(zip: text) ?? Address();
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Subdivision/Colonia',
                deBounce: Duration(milliseconds: 300),
                isEnabled: isEnabled,
                maxLength: 30,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.address.subdivision,
                ),
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.address = location.address.sanitize(subdivision: text) ?? Address().sanitize(subdivision: text) ?? Address();
                  itemState?.react();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}