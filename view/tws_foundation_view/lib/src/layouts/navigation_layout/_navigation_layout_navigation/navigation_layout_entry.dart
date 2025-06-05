import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart' hide Route;
import 'package:tws_foundation_view/tws_foundation_view.dart';

/// Defines contract for a [NavigationLayout] entry, wich define members to build correctly the navigation menu buttons
/// and handle the routing behavior.
abstract interface class NavigationLayoutEntryI {
  /// Navigation button title.
  final String title;

  /// Navigation button target route.
  final Route route;

  /// Button icon builder.
  final ImageProvider Function(BuildContext context) iconBuilder;

  /// Creates a new [NavigationLayoutEntryI] instance.
  const NavigationLayoutEntryI({
    required this.title,
    required this.route,
    required this.iconBuilder,
  });
}

/// {model} class.
///
/// Implements a data {model} that stores information to correctly build a Navigation Menu button and its routing behavior.
final class NavigationLayoutEntry extends NavigationLayoutEntryI {
  /// Creates a new [NavigationLayoutEntry] instance.
  const NavigationLayoutEntry({
    required super.title,
    required super.route,
    required super.iconBuilder,
  });
}
