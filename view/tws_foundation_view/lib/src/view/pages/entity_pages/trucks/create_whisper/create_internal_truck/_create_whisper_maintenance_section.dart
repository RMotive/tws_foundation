part of '../trucks_page_create_whisper.dart';

class _CreateWhisperMaintenanceection extends StatelessWidget {
  final CreateEntityFormRecordReactor<TruckCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperMaintenanceection({
    required this.itemState,
    required this.isEnabled,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: <Widget>[
        const SectionDivider(text: 'Maintenance Details'),
        Datepicker(
          width: double.maxFinite,
          label: '*Anual maintenance',
          isDisabled: isEnabled,
          controller: TextEditingController(
            text: itemState?.entity.internal?.maintenance?.anual.dateOnly,
          ),
          firstDate: DateTime(1950),
          lastDate: DateTime(DateTime.now().year),
          onChanged: (String? date) {
            itemState?.entity.internal?.maintenance =
                itemState?.entity.internal?.maintenance?.sanitize(
                  anual: DateTime.tryParse(date ?? "") ?? DateTime(0),
                ) ??
                Maintenance().sanitize(
                  anual: DateTime.tryParse(date ?? "") ?? DateTime(0),
                );
            itemState?.entity.internal?.maintenance?.status = _defaultStatus;
            itemState?.react();
          },
        ),
        Datepicker(
          width: double.maxFinite,
          label: '*Trimestral Maintenance',
          isDisabled: isEnabled,
          controller: TextEditingController(
            text: itemState?.entity.internal?.maintenance?.trimestral.dateOnly,
          ),
          firstDate: DateTime(1950),
          lastDate: DateTime(DateTime.now().year),
          onChanged: (String? date) {
            itemState?.entity.internal?.maintenance =
                itemState?.entity.internal?.maintenance?.sanitize(
                  trimestral: DateTime.tryParse(date ?? "") ?? DateTime(0),
                ) ??
                Maintenance().sanitize(
                  trimestral: DateTime.tryParse(date ?? "") ?? DateTime(0),
                );
            itemState?.entity.internal?.maintenance?.status = _defaultStatus;
            itemState?.react();
          },
        ),
      ],
    );
  }
}