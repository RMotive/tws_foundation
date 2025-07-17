using System.ComponentModel.DataAnnotations;

namespace CSM_Foundation.Database.Entity.Bases;

/// <summary>
///     Represents an <see cref="IEntity"/> with <see cref="BNamedEntity.Name"/> and <see cref="BNamedEntity.Description"/> properties
///     that can help to identify a <see cref="IEntity"/> based on <see cref="BNamedEntity.Name"/> property as this defines them as unique.
/// </summary>
public interface INamedReferencedEntity
    : IEntity, IReferencedEntity {

    /// <summary>
    ///     Entity instance name.
    /// </summary>
    /// <remarks>
    ///     Length must be between 1 and 100.
    /// </remarks>
    [StringLength(100, MinimumLength = 1)]
    string Name { get; set; }

    /// <summary>
    ///     Entity instance description.
    /// </summary>
    string? Description { get; set; }
}

/// <summary>
///     Represents an <see cref="IEntity"/> with <see cref="Name"/> and <see cref="Description"/> properties
///     that can help to identify a <see cref="IEntity"/> based on <see cref="Name"/> property as this defines them as unique.
/// </summary>
public abstract class BNamedReferencedEntity
    : BEntity, INamedReferencedEntity {

    public string Name { get; set; } = string.Empty;

    public string Reference { get; set;} = string.Empty;

    public string? Description { get; set; }
}