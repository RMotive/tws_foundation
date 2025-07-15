/// {enum} definitions.
///
/// Defines the available types for a [UserFeedback].
enum UserFeedbackType {
  /// When the feedback is an error result.
  error,

  /// When the feedback is a success result.
  success,

  /// When the feedback is a message.
  message,

  /// When the feedback is a warning.
  warning,
}

/// {model} class.
///
/// Data model class that stores an user feedback information object result from a server operation.
final class UserFeedback {
  /// Feedback object type.
  final UserFeedbackType type;

  final String message;

  /// Creates a new [UserFeedback] instance.
  UserFeedback({
    this.type = UserFeedbackType.message,
    required this.message,
  });
}
