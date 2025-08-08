/// {model} class.
///
/// A model representing a text label with a title and value.
final class TextLabel {
  /// label title.
  final String title;

  /// label message.
  final String value;

  /// Creates a new [TextLabel] instance.
  const TextLabel({
    required this.title,
    required this.value,
  });
}