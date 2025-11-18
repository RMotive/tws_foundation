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
    itemState!.entity.internal!.employee.status = _defaultStatus;
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
                label: '*First lastname',
                isEnabled: isEnabled,
                maxLength: 32,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.identification.name,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.identification.firstLastName = text;
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
                label: 'Second lastname',
                isEnabled: isEnabled,
                maxLength: 32,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.identification.name,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.identification.secondLastName = text;
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
                label: 'Curp',
                isEnabled: isEnabled,
                maxLength: 18,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.curp,
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
                    text: itemState?.entity.internal?.employee.identification.birthDay?.dateOnly,
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

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: Datepicker(
                width: double.maxFinite,
                label: 'Cnap date',
                isDisabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.dates.cnap?.dateOnly,
                ),
                firstDate: DateTime(1950),
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if (date == null) {
                    employee.dates.cnap = null;
                    return;
                  }
                  employee.dates.cnap = DateTime.tryParse(date);
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: Datepicker(
                width: double.maxFinite,
                label: 'Hire date',
                isDisabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.dates.hire?.dateOnly,
                ),
                firstDate: DateTime(1950),
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if (date == null) {
                    employee.dates.hire = null;
                    return;
                  }
                  employee.dates.hire = DateTime.tryParse(date);
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
              child: Datepicker(
                width: double.maxFinite,
                label: 'imss registration date',
                isDisabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.dates.imss?.dateOnly,
                ),
                firstDate: DateTime(1950),
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if (date == null) {
                    employee.dates.imss = null;
                    return;
                  }
                  employee.dates.imss = DateTime.tryParse(date);
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: Datepicker(
                width: double.maxFinite,
                label: 'Termination date',
                isDisabled: isEnabled,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.dates.termination?.dateOnly,
                ),
                firstDate: DateTime(1950),
                lastDate: DateTime(DateTime.now().year),
                onChanged: (String? date) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if (date == null) {
                    employee.dates.termination = null;
                    return;
                  }
                  employee.dates.termination = DateTime.tryParse(date);
                  itemState?.react();
                },
              ),
            ),
          ],
        ),

        /// --> Driver Contact Information.
        FoldPanelWidget(
          title: ' Add Contact information',
          child: _CreateWhisperApproachSection(
            itemState: itemState,
            isEnabled: isEnabled,
          ),
        ),

        /// --> Driver Address Information.
        FoldPanelWidget(
          title: 'Add Address information',
          child: _CreateWhisperAddressSection(
            itemState: itemState,
            isEnabled: isEnabled,
          ),
        ),
      ],
    );
  }
}
