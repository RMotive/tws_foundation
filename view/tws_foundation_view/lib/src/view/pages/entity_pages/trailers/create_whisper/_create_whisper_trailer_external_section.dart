part of 'trailers_page_create_whisper.dart';

class _CreateWhisperTrailersExternalSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TrailerCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperTrailersExternalSection({
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
                label: 'Carrier',
                isEnabled: isEnabled,
                maxLength: 12,
                controller: TextEditingController(
                  text: itemState?.entity.external?.carrier,
                ),
                onChanged: (String text) {
                  TrailerExternal trailer = itemState!.entity.external!;
                  trailer.carrier = text;
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
                  TrailerExternal trailer = itemState!.entity.external!;
                  trailer.usaPlate = text;
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
                  TrailerExternal trailer = itemState!.entity.external!;
                  trailer.mxPlate = text;
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