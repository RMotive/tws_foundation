/// Custom class for action implementations on [TwsOptionSelector] widget.
class TwsOptionSelectorAction<T> {
  // Action title.
  final String title;
  // Action value. Returned when action is selected.
  final T value;
  // Min width.
  final double minWidth;
  // Max width
  final double maxWidth;

  const TwsOptionSelectorAction({
    required this.title,
    required this.value,
    this.minWidth = double.maxFinite,
    this.maxWidth = double.maxFinite,
  });
}
