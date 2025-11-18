part of 'locations_page_create_whisper.dart';

class _CreateWhisperWaypointsSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<Location>? itemState;
  final bool isEnabled;

  const _CreateWhisperWaypointsSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// --> Driver Address Information.
        const SectionDivider(
          text: "Waypoint Information",
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Longitude',
                isEnabled: isEnabled,
                keyboardType: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
                  CoordenatesPrecisionFormtter(),
                ],
                controller: TextEditingController(
                  text: itemState?.entity.waypoint?.longitude.toString(),
                ),
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.waypoint = location.waypoint?.sanitize(longitude: double.tryParse(text) ?? 0.0) ?? Waypoint().sanitize(longitude: double.tryParse(text) ?? 0.0);
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Latitude',
                isEnabled: isEnabled,
                keyboardType: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
                  CoordenatesPrecisionFormtter(),
                ],
                controller: TextEditingController(
                  text: itemState?.entity.waypoint?.latitude.toString(),
                ),
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.waypoint = location.waypoint?.sanitize(latitude: double.tryParse(text) ?? 0.0) ?? Waypoint().sanitize(latitude: double.tryParse(text) ?? 0.0);
                  itemState?.react();
                },
              ),
            ),
          ],
        ),
        TextInput(
          width: double.maxFinite,
          label: 'Altitude',
          isEnabled: isEnabled,
          keyboardType: TextInputType.number,
          formatter: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
            CoordenatesPrecisionFormtter(),
          ],
          controller: TextEditingController(
            text: itemState?.entity.waypoint?.altitude.toString(),
          ),
          onChanged: (String text) {
            Location location = itemState!.entity;
            location.waypoint = location.waypoint?.sanitize(altitude: double.tryParse(text) ?? 0.0) ?? Waypoint().sanitize(altitude: double.tryParse(text) ?? 0.0);
            itemState?.react();
          },
        ),
      ],
    );
  }
}