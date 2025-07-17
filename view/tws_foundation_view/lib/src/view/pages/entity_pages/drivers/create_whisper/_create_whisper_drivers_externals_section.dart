part of 'drivers_page_create_whisper.dart';

class _CreateWhisperDriversExternalsSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<DriverCommon>? itemState;

  final bool isDisabled;

  const _CreateWhisperDriversExternalsSection({
    required this.itemState,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      children: <Widget>[
        /// --> Driver License
        TextInput(
          label: 'Name',
          isEnabled: isDisabled,
          controller: TextEditingController(
            text: itemState?.entity.external?.identification.name,
          ),
          onChanged: (String text) {
            DriverExternal driver = itemState!.entity.external!;
            driver.identification.name = text;
            itemState?.react();
          },
        ),

      ],
    );
  }
}