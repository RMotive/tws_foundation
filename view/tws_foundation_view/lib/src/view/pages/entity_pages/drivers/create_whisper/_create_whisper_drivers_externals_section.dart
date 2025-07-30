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
        /// --> Driver Information.
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
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
            ),
            
            Expanded(
              child: TextInput(
                label: 'Lastname',
                isEnabled: isDisabled,
                controller: TextEditingController(
                  text: itemState?.entity.external?.identification.lastName,
                ),
                onChanged: (String text) {
                  DriverExternal driver = itemState!.entity.external!;
                  driver.identification.lastName = text;
                  itemState?.react();
                },
              ),
            ),

          ],
        ),
          
        Datepicker(
          width: double.maxFinite,
          label: 'Birthday',
          isDisabled: isDisabled,
          controller: TextEditingController(text: itemState?.entity.external?.identification.birthDay?.dateOnly),
          firstDate: DateTime(1950), 
          lastDate: DateTime(DateTime.now().year),
          onChanged: (String? date) {
            DriverExternal driver = itemState!.entity.external!;
            if (date == null) {
              driver.identification.birthDay = null;
              return;
            }
            driver.identification.birthDay = DateTime.tryParse(date);
            itemState?.react();
          },
        ),
      ],
    );
  }
}