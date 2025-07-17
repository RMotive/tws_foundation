part of 'drivers_page_create_whisper.dart';

class _EmployeeCreationState extends ReactorB { }
final _EmployeeCreationState _employeeState = _EmployeeCreationState();

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
        TextInput(
          width: double.maxFinite,
          label: 'Driver type',
          isEnabled: isEnabled,
          maxLength: 12,
          controller: TextEditingController(
            text: itemState?.entity.internal?.driverType,
          ),
          onChanged: (String text) {
            Driver driver = itemState!.entity.internal!;
            driver.driverType = text;
            itemState?.react();
          },
        ),

        ReactiveWidget<_EmployeeCreationState>(
          reactor: _employeeState,
          builder: (BuildContext ctx, _EmployeeCreationState reactor) {
            return CascadeSection(
              title: 'Driver Data', 
              mainControl: Expanded(
                child: AutoCompleteField<Employee>(
                  adapter: const _EmployeesViewAdapter(),
                  label: 'Select Employee',
                  isOptional: true,
                  isEnabled: isEnabled,
                  initialValue: itemState?.entity.internal?.employee,
                  hasKeyValue: (Employee? item) {
                      if(item?.id != null) return item!.id > BigInt.zero;
                      return false;
                    },
                  displayValue:(Employee? employee) {
                    return employee?.fullName ?? 'invalid employee';
                  },
                  onChanged:(Employee? selection) {
                    if(selection == null) {
                      itemState?.entity.internal?.employee = Employee();
                    } else {
                      itemState?.entity.internal?.employee = selection;
                    }
                    itemState?.react();
                  },
                ),
              ), 
              loadOnPress:(bool isShowing) {
                return Container();
              },
            );
          },
        ),
        /// --> Driver VISA fields.
        Row(
          spacing: 12,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Visa',
                isEnabled: isEnabled,
                maxLength: 12,
                isFixedLength: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.visa,
                ),
                onChanged: (String text) {
                  Driver driver = itemState!.entity.internal!;
                  driver.visa = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Datepicker(
                  label: 'VISA Expiration',
                  isDisabled: isEnabled,
                  controller: TextEditingController(text: itemState?.entity.internal?.visaExpiration?.dateOnlyString),
                  firstDate: DateTime(1999), 
                  lastDate: DateTime(DateTime.now().year),
                  onChanged: (String? date) {
                    Driver driver = itemState!.entity.internal!;
                    if (date == null) {
                      driver.visaExpiration = null;
                      return;
                    }
                    driver.visaExpiration = DateTime.tryParse(date);
                    itemState?.react();
                  },
                ),
              ),
            ),
          ],
        ),

        /// --> Driver FAST fields.
        Row(
          spacing: 12,
          children: <Widget>[
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Datepicker(
                  label: 'FAST Expiration',
                  isDisabled: isEnabled,
                  controller: TextEditingController(text: itemState?.entity.internal?.fastExpiration?.dateOnlyString),
                  firstDate: DateTime(1999), 
                  lastDate: DateTime(DateTime.now().year),
                  onChanged: (String? date) {
                    Driver driver = itemState!.entity.internal!;
                    if (date == null) {
                      driver.fastExpiration = null;
                      return;
                    }
                    driver.fastExpiration = DateTime.tryParse(date);
                    itemState?.react();
                  },
                ),
              ),
            ),
          ],
        ),
        /// --> Driver ANAM fields
        Row(
          spacing: 12,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'ANAM',
                isEnabled: isEnabled,
                maxLength: 24,
                isFixedLength: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.anam,
                ),
                onChanged: (String text) {
                  Driver driver = itemState!.entity.internal!;
                  driver.anam = text;
                  itemState?.react();
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Datepicker(
                  label: 'ANAM Expiration',
                  isDisabled: isEnabled,
                  controller: TextEditingController(text: itemState?.entity.internal?.anamExpiration?.dateOnlyString),
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
        ),

        /// --> Driver ANAM fields
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
                  isDisabled: isEnabled,
                  controller: TextEditingController(text: itemState?.entity.internal?.anamExpiration?.dateOnlyString),
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
        ),

        /// --> Driver TWIC fields.
        Row(
          spacing: 12,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Twic',
                isEnabled: isEnabled,
                maxLength: 12,
                isFixedLength: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.twic,
                ),
                onChanged: (String text) {
                  Driver driver = itemState!.entity.internal!;
                  driver.twic = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Datepicker(
                  label: 'Twic Expiration',
                  isDisabled: isEnabled,
                  controller: TextEditingController(text: itemState?.entity.internal?.twicExpiration?.dateOnlyString),
                  firstDate: DateTime(1999), 
                  lastDate: DateTime(DateTime.now().year),
                  onChanged: (String? date) {
                    Driver driver = itemState!.entity.internal!;
                    if (date == null) {
                      driver.twicExpiration = null;
                      return;
                    }
                    driver.twicExpiration = DateTime.tryParse(date);
                    itemState?.react();
                  },
                ),
              ),
            ),
          ],
        ),
        
        
      ],
    );
  }
}