part of 'category_layout.dart';

final class _CategoryLayoutMessenger extends StatefulWidget {
  /// Creates a new [_CategoryLayoutMessenger] instance.
  const _CategoryLayoutMessenger({super.key});

  @override
  State<_CategoryLayoutMessenger> createState() => CategoryLayoutMessengerState();
}

/// Handles [State] for [_CategoryLayoutMessenger].
final class CategoryLayoutMessengerState extends State<_CategoryLayoutMessenger> {
  /// {state} current messages being shown.
  final List<UserFeedback> _messageBag = <UserFeedback>[];

  /// Pushes a new [message] to be shown to the user at the current stack.
  void pushMessage(UserFeedback message) {
    setState(() {
      _messageBag.add(message);
    });
  }

  /// Pushes a new collection of [messages] to be shown to the user at the current stack.
  void pushMessages(List<UserFeedback> messages) {
    setState(() {
      _messageBag.addAll(messages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16.0,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              spacing: 8,
              children: <Widget>[
                for (UserFeedback userFeedback in _messageBag)
                  _MessageChip(
                    key: ValueKey<int>(userFeedback.hashCode),
                    messageData: userFeedback,
                    onDismiss: () {
                      setState(() {
                        _messageBag.remove(userFeedback);
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws and handles an user feedback message display at the [_CategoryLayoutMessenger] stack.
final class _MessageChip extends StatefulWidget {
  /// User feedback message data.
  final UserFeedback messageData;

  /// Callback invoked when {dismiss} event is requested.
  final void Function() onDismiss;

  /// Creats a new [_MessageChip] instance.
  const _MessageChip({
    super.key,
    required this.messageData,
    required this.onDismiss,
  });

  @override
  State<_MessageChip> createState() => _MessageChipState();
}

/// Handles [State] for [_MessageChip].
final class _MessageChipState extends State<_MessageChip> {
  /// {state} current application theme data.
  late FoundationThemeB themeData;

  /// {state} whether the current [Widget] is to be dismissed.
  bool _dismissed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    themeData = Theming.get(context);
  }

  /// {event} when the current [Widget] is to be dismissed, dismission will animate {opacity} during 500 milliseconds
  /// and after it finishes will remove the message from the stack.
  void onDismiss() {
    setState(() {
      _dismissed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserFeedback messageData = widget.messageData;

    Color accentColor = switch (messageData.type) {
      UserFeedbackType.error => themeData.error.accent,
      UserFeedbackType.success => themeData.success.accent,
      UserFeedbackType.message => themeData.control.accent,
      UserFeedbackType.warning => themeData.warning.accent,
    };

    return AnimatedOpacity(
      duration: 500.miliseconds,
      opacity: !_dismissed ? 1 : 0,
      onEnd: widget.onDismiss,
      child: PointerArea(
        cursor: SystemMouseCursors.click,
        onClick: onDismiss,
        child: BorderedBox(
          color: accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 14,
            ),
            child: Text(
              widget.messageData.message,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
