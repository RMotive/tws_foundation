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
                controller: TextEditingController(
                  text: itemState?.entity.waypoint?.longitude.toString(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String text) {
                  Location location = itemState!.entity;
                  location.waypoint ??= Waypoint();
                  location.waypoint!.longitude = double.tryParse(text) ?? 0.0;
                  itemState.react();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}