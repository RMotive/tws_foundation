/// [enum] definitions.
///
/// Defines the available types for a [EntityCreationForm] feedback object.
enum EntityCreationFormFeedbackTypes {
  /// When the feedback is an error result.
  error,

  /// When the feedback is a success result.
  success,

  /// When the feedback is a message.
  message,

  /// When the feedback is a warning.
  warning,
}

/// {model} implementaiton.
///
/// Defines a data model that stores information about a result feedback from [EntityCreationForm] operation.
final class EntityCreationFormFeedback {
  /// Type of the current feedback.
  final EntityCreationFormFeedbackTypes type;

  /// Creates a new [EntityCreationFormFeedback] instance.
  const EntityCreationFormFeedback(this.type);
}
