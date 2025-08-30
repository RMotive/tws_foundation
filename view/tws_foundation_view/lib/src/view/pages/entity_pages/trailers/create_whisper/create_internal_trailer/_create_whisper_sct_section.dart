
part of '../trailers_page_create_whisper.dart';
class _CreateWhisperSCTSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TrailerCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperSCTSection({
    required this.itemState,
    required this.isEnabled,
  });
  
  @override
  Widget build(BuildContext context) {
    // TODO ASK if is necesary do an entity finder selector.
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'SCT Details'),
        TextInput(
          label: '*Type',
          maxLength: 6,
          isFixedLength: true,
          controller: TextEditingController(text: itemState?.entity.internal?.sct?.type),
          onChanged: (String value){
            itemState?.entity.internal?.sct = itemState?.entity.internal?.sct?.sanitize(type: value) ?? SCT().sanitize(type: value);
            itemState?.entity.internal?.sct?.status = _defaultStatus;
            itemState?.react();
          },
        ),
        TextInput(
          label: '*Number',
          maxLength: 25,
          isFixedLength: true,
          controller: TextEditingController(text: itemState?.entity.internal?.sct?.number),
          onChanged: (String value) {
            itemState?.entity.internal?.sct =
                itemState?.entity.internal?.sct?.sanitize(number: value) ?? SCT().sanitize(type: value);
            itemState?.entity.internal?.sct?.status = _defaultStatus;
            itemState?.react();
          } 
        ),
        TextInput(
          label: '*Configuration',
          maxLength: 10,
          controller: TextEditingController(text: itemState?.entity.internal?.sct?.configuration),
          onChanged: (String value) {
            itemState?.entity.internal?.sct =
                itemState?.entity.internal?.sct?.sanitize(configuration: value) ?? SCT().sanitize(type: value);
            itemState?.entity.internal?.sct?.status = _defaultStatus;
            itemState?.react();
          },
        ),
      ],
    );
  }
}