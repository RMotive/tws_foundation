part of '../trucks_page_create_whisper.dart';

class _CreateWhisperInsuranceSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TruckCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperInsuranceSection({
    required this.itemState,
    required this.isEnabled,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'Insurance Details'),
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: '*Policy',
                maxLength: 20,
                controller: TextEditingController(text: itemState?.entity.internal?.insurance?.policy),
                onChanged: (String value){
                  itemState?.entity.internal?.insurance =
                      itemState?.entity.internal?.insurance?.sanitize(policy: value) ??
                      Insurance().sanitize(policy: value);
                  itemState?.entity.internal?.insurance?.status = _defaultStatus;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AutoCompleteField<String>(
                  isEnabled: isEnabled,
                  nativeList: _countries,
                  initialValue: itemState?.entity.internal?.insurance?.country == "" ? null :  itemState?.entity.internal?.insurance?.country,
                  displayValue:(String? item) => item ?? "Invalid data",
                  label: '*Country',
                  onChanged: (String? text) {
                    itemState?.entity.internal?.insurance =
                        itemState?.entity.internal?.insurance?.sanitize(country: text ?? "") ??
                        Insurance().sanitize(country: text ?? "");
                    itemState?.entity.internal?.insurance?.status = _defaultStatus;
                    itemState?.react();
                  },
                ),
              ),
            ),
          ],
        ),
        
        Datepicker(
          width: double.maxFinite,
          label: '*Expiration',
          isDisabled: isEnabled,
          controller: TextEditingController(
            text: itemState?.entity.internal?.insurance?.expiration.dateOnly,
          ),
          firstDate: DateTime(1950),
          lastDate: DateTime(DateTime.now().year),
          onChanged: (String? date) {
            itemState?.entity.internal?.insurance =
                itemState?.entity.internal?.insurance?.sanitize(
                  expiration: DateTime.tryParse(date ?? "") ?? DateTime(0),
                ) ??
                Insurance().sanitize(
                  expiration: DateTime.tryParse(date ?? "") ?? DateTime(0),
                ); 
            itemState?.entity.internal?.insurance?.status = _defaultStatus;
            itemState?.react();
          },
        ),
      ],
    );
  }
}