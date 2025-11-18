part of 'trucks_page_create_whisper.dart';

class _CreateWhisperTrucksExternalSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TruckCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperTrucksExternalSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Vin',
                isEnabled: isEnabled,
                maxLength: 17,
                controller: TextEditingController(
                  text: itemState?.entity.external?.vin,
                ),
                onChanged: (String text) {
                  TruckExternal truck = itemState!.entity.external!;
                  truck.vin = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Carrier',
                isEnabled: isEnabled,
                maxLength: 100,
                controller: TextEditingController(
                  text: itemState?.entity.external?.carrier,
                ),
                onChanged: (String text) {
                  TruckExternal truck = itemState!.entity.external!;
                  truck.carrier = text;
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
                label: 'USA Plate',
                isEnabled: isEnabled,
                maxLength: 7,
                controller: TextEditingController(
                  text: itemState?.entity.external?.usaPlate,
                ),
                onChanged: (String text) {
                  TruckExternal truck = itemState!.entity.external!;
                  truck.usaPlate = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'MX Plate',
                isEnabled: isEnabled,
                maxLength: 7,
                controller: TextEditingController(
                  text: itemState?.entity.external?.mxPlate,
                ),
                onChanged: (String text) {
                  TruckExternal truck = itemState!.entity.external!;
                  truck.mxPlate = text;
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