part of 'drivers_page_create_whisper.dart';

class _CreateWhisperDriversSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<DriverCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperDriversSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      children: <Widget>[

        Row(
          spacing: 12,
          children: <Widget>[
            /// --> Driver FAST number.
            Expanded(
              child: TextInput(
                label: 'Fast',
                isEnabled: isEnabled,
                maxLength: 12,
                isFixedLength: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.fast,
                ),
                onChanged: (String text) {
                  Driver driver = itemState!.entity.internal!;
                  driver.fast = text;
                  itemState?.react();
                },
              ),
            ),
          ],
        ),
        /// --> Driver ANAM Data
        Row(
          spacing: 12,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'ANAM',
                isEnabled: isEnabled,
                maxLength: 12,
                isFixedLength: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.anam,
                ),
                onChanged: (String text) {
                  Driver driver = itemState!.entity.internal!;
                  driver.fast = text;
                  itemState?.react();
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Datepicker(
                  label: 'ANAM Expiration',
                  isEnabled: isEnabled,
                  controller: TextEditingController(text: itemState?.entity.internal?.anamExpiration?.toString()),
                  firstDate: DateTime(1999), 
                  lastDate: DateTime(DateTime.now().year),
                  onChanged: (String? date) {
                    Driver driver = itemState!.entity.internal!;
                    if (date == null) {
                      driver.anamExpiration = null;
                      return;
                    }
                    driver.anamExpiration = DateTime.tryParse(date);
                    itemState?.react();
                  },
                ),
              ),
            ),
          ],
        )
        
      ],
    );
  }
}