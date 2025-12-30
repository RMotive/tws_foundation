import 'package:csm_client/csm_client.dart';

/// {interface} for [ViewFilterNodeI].
///
/// Defines a contract for [ViewFilterNodeI] implementations wich specifies a data filtering instruction
/// to the {View} operation for a certain {Set} of [T] type entities.
abstract interface class ViewFilterNodeI<T extends EntityI<T>> implements EncodableI {
  /// Unique operation time variation identification for transaction convertions.
  final String discriminator;

  /// Filtering application order when a collection of [ViewFilterNodeI] was given.
  final int order;

  /// Creates a new [ViewFilterNodeI] instance.
  const ViewFilterNodeI(this.discriminator, this.order);
}

/// {enum} for [ViewFilterNodeI.discriminator] values.
/// 
/// Defines the possible filter node/discriminator values for [ViewFilterNodeI] implementations.
enum ViewFilterDiscriminator { 
  ///
  logical,
  /// 
  property,
  ///  
  date,
}
