part of 'accounts_page_create_whisper.dart';

class _CreateWhisperContactsSection extends StatelessWidget {
  final CreateEntityFormRecordReactor<Account>? itemState;
  final bool isEnabled;

  const _CreateWhisperContactsSection({
    required this.itemState,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: <Widget>[
        /// --> Contact Full Name
        Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// --> Contact Name
            Expanded(
              child: TextInput(
                label: '*Name',
                isEnabled: isEnabled,
                maxLength: 100,
                controller: TextEditingController(
                  text: itemState?.entity.contact.name,
                ),
                onChanged: (String text) {
                  Account account = itemState!.entity;
                  account.contact.name = text;
                  itemState?.react();
                },
              ),
            ),
            /// --> Contact Name
            Expanded(
              child: TextInput(
                label: '*Lastname',
                isEnabled: isEnabled,
                maxLength: 100,
                controller: TextEditingController(
                  text: itemState?.entity.contact.lastName,
                ),
                onChanged: (String text) {
                  Account account = itemState!.entity;
                  account.contact.eMail = text;
                  itemState?.react();
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: <Widget>[
            /// --> Contact Email
            Expanded(
              child: TextInput(
                label: '*Email',
                isEnabled: isEnabled,
                maxLength: 100,
                controller: TextEditingController(
                  text: itemState?.entity.contact.eMail,
                ),
                onChanged: (String text) {
                  Account account = itemState!.entity;
                  account.contact.eMail = text;
                  itemState?.react();
                },
              ),
            ),
  
            /// --> Phone number
            Expanded(
              child: TextInput(
                label: '*Phone number',
                isEnabled: isEnabled,
                maxLength: 14,
                controller: TextEditingController(
                  text: itemState?.entity.contact.phone,
                ),
                onChanged: (String text) {
                  Account account = itemState!.entity;
                  account.contact.phone = text;
                  itemState?.react();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}