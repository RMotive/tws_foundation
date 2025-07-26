part of '../drivers_page_create_whisper.dart';

class _CreateWhisperEmployeeSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<DriverCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperEmployeeSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EntityFinderSelector<Status, StatusesServiceI>(
          entityBuilder: () => Status(),
          label: '*Assing an status...',
          enabled:true,
          initialValue: itemState?.entity.internal?.employee.status,
          textBuilder: (Status status) {
            return status.name;
          },
          onSelected: (Status? status) {
            itemState?.entity.internal?.employee.status = status ?? Status();
            itemState?.react();
          },
        ),

        /// --> Employee Identification Information.
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: '*Name',
                isEnabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.identification.name,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.identification.name = text;
                  itemState?.react();
                },
              ),
            ),
            
            Expanded(
              child: TextInput(
                label: '*Lastname',
                isEnabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.identification.name,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.identification.lastName = text;
                  itemState?.react();
                },
              ),
            ),

          ],
        ),

        /// --> Employee internal information.
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Curp',
                isEnabled: isEnabled,
                maxLength: 18,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.driverType,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.curp = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Datepicker(
                  width: double.maxFinite,
                  label: 'Birthday',
                  isDisabled: isEnabled,
                  controller: TextEditingController(
                    text: itemState?.entity.internal?.employee.identification.birthDay?.dateOnlyString,
                  ),
                  firstDate: DateTime(1950), 
                  lastDate: DateTime(DateTime.now().year),
                  onChanged: (String? date) {
                    Employee employee = itemState!.entity.internal!.employee;
                    if (date == null) {
                      employee.identification.birthDay = null;
                      return;
                    }
                    employee.identification.birthDay = DateTime.tryParse(date);
                    itemState?.react();
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                width: double.maxFinite,
                label: 'nss',
                isEnabled: isEnabled,
                maxLength: 12,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.rfc,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.nss = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Rfc',
                isEnabled: isEnabled,
                maxLength: 12,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.rfc,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.rfc = text;
                  itemState?.react();
                },
              ),
            ),
          ],
        ),

        /// --> Driver Contact Information.
        _CreateWhisperApproachSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),

        /// --> Driver Address Information.
        _CreateWhisperAddressSection(
          itemState: itemState,
          isEnabled: isEnabled,
        ),
        
        
      ],
    );
  }
}