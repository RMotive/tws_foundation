part of 'employees_page_create_whisper.dart';

class _CreateWhisperApproachSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<Employee>? itemState;

  final bool isEnabled;

  const _CreateWhisperApproachSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 10,
            children: <Widget>[
              Expanded(
                child: TextInput(
                  label: 'Email',
                  isEnabled: isEnabled,
                  deBounce: Duration(milliseconds: 300),
                  maxLength: 64,
                  isOptional: true,
                  controller: TextEditingController(
                    text: itemState?.entity.approach?.email,
                  ),
                  onChanged: (String text) {
                    Employee employee = itemState!.entity;
                    itemState!.entity.approach?.status = _defaultStatus;
                    employee.approach = employee.approach?.sanitize(email: text) ?? Approach().sanitize(email: text);
                    itemState?.react();
                  },
                ),
              ),
      
              Expanded(
                child: TextInput(
                  label: 'Enterprise phone',
                  deBounce: Duration(milliseconds: 300),
                  isEnabled: isEnabled,
                  maxLength: 13,
                  isOptional: true,
                  controller: TextEditingController(
                    text: itemState?.entity.approach?.enterprise,
                  ),
                  onChanged: (String text) {
                    Employee employee = itemState!.entity;
                    itemState!.entity.approach?.status = _defaultStatus;
                    employee.approach =
                        employee.approach?.sanitize(enterprise: text) ?? Approach().sanitize(enterprise: text);
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
                  label: 'Personal phone',
                  isEnabled: isEnabled,
                  maxLength: 13,
                  deBounce: Duration(milliseconds: 300),
                  isOptional: true,
                  controller: TextEditingController(
                    text: itemState?.entity.approach?.personal,
                  ),
                  onChanged: (String text) {
                    Employee employee = itemState!.entity;
                    itemState!.entity.approach?.status = _defaultStatus;
                    employee.approach =
                        employee.approach?.sanitize(personal: text) ?? Approach().sanitize(personal: text); 
                    itemState?.react();
                  },
                ),
              ),
              Expanded(
                child: TextInput(
                  label: 'Alternative contact',
                  isEnabled: isEnabled,
                  deBounce: Duration(milliseconds: 300),
                  maxLength: 30,
                  isOptional: true,
                  controller: TextEditingController(
                    text: itemState?.entity.approach?.alternative,
                  ),
                  onChanged: (String text) {
                    Employee employee = itemState!.entity;
                    itemState!.entity.approach?.status = _defaultStatus;
                    employee.approach =
                        employee.approach?.sanitize(alternative: text) ?? Approach().sanitize(alternative: text);
                    itemState?.react();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}