namespace CSM_Foundation.Database.Entity;

/// <summary>
///     Attribute to mark a property as a relation from the main Entity.
/// </summary>
/// <remarks>
///     Mainly used on <see cref="IEntity"/> implementations for [CSM] automatic quality and featured 
///     functionalities for data handling.
/// </remarks>
[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
public class RelationAttribute
    : Attribute {
}
