part of '../drivers_page_create_whisper.dart';

class _CreateWhisperApproachSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<DriverCommon>? itemState;

  final bool isEnabled;

  const _CreateWhisperApproachSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        TWSSectionDivider(
          text: "Contact Information",
        ),

        Row(
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: TextInput(
                label: 'Email',
                isEnabled: isEnabled,
                maxLength: 64,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.approach?.email,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  employee.approach?.email = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Enterprise phone',
                isEnabled: isEnabled,
                maxLength: 13,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.approach?.enterprise,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.approach?.enterprise = null;
                    return;
                  }
                  employee.approach?.enterprise = text;
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
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.approach?.personal,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.approach?.personal = null;
                    return;
                  }
                  employee.approach?.personal = text;
                  itemState?.react();
                },
              ),
            ),
            Expanded(
              child: TextInput(
                label: 'Alternative contact',
                isEnabled: isEnabled,
                maxLength: 30,
                isOptional: true,
                controller: TextEditingController(
                  text: itemState?.entity.internal?.employee.approach?.alternative,
                ),
                onChanged: (String text) {
                  Employee employee = itemState!.entity.internal!.employee;
                  if(text.trim().isEmpty){
                    employee.approach?.alternative = null;
                    return;
                  }
                  employee.approach?.alternative = text;
                  itemState?.react();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}