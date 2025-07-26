part of '../drivers_page_create_whisper.dart';

class _CreateWhisperAddressSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<DriverCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperAddressSection({
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
        TWSSectionDivider(
          text: "Address Information",
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: AutoCompleteField<String>(
                isEnabled: isEnabled,
                nativeList: countries,
                initialValue: itemState?.entity.internal?.employee.address?.country == "" ? null :  itemState?.entity.internal?.employee.address?.country,
                displayValue:(String? item) => item ?? "Not valid data",
                label: 'Country',
                onChanged: (String? text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.address?.country = text ?? "";
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: AutoCompleteField<String>(
                isEnabled: isEnabled,
                nativeList: statesUSA,
                initialValue: itemState?.entity.internal?.employee.address?.state == "" ? null :  itemState?.entity.internal?.employee.address?.state,
                displayValue:(String? item) => item ?? "Not valid data",
                label: 'State',
                isOptional: true,
                onChanged: (String? text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.address?.state = text;
                  itemState?.react();
                },
              ),
            ),
          ],
        ),

        TextInput(
          width: double.maxFinite,
          label: 'City',
          isEnabled: isEnabled,
          maxLength: 30,
          isOptional: true,
          controller: TextEditingController(
            text: itemState?.entity.internal?.employee.address?.city,
          ),
          onChanged: (String text) {
            Employee employee = itemState!.entity.internal!.employee;
            if(text.trim().isEmpty){
              employee.address?.city = null;
              return;
            }
            employee.address?.city = text;
            itemState?.react();
          },
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Street',
                isEnabled: isEnabled,
                maxLength: 100,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.address?.street,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.address?.street = null;
                    return;
                  }
                  employee.address?.state = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Alternative Street',
                isEnabled: isEnabled,
                maxLength: 100,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.address?.altStreet,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.address?.altStreet = null;
                    return;
                  }
                  employee.address?.altStreet = text;
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
                isEnabled: isEnabled,
                maxLength: 5,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.address?.zip,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.address?.zip = null;
                    return;
                  }
                  employee.address?.zip = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Subdivision/Colonia',
                isEnabled: isEnabled,
                maxLength: 13,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.address?.subdivision,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.address?.subdivision = null;
                    return;
                  }
                  employee.address?.subdivision = text;
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