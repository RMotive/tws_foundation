using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Convertion;

namespace CSM_Foundation.Database.Entity.Bases;


/// <summary>
///     Represents an <see cref="IEntity"/> with a <see cref="Reference"/> unique property wich allows its identification along
///     data storages migrations as this property is absolute static.
/// </summary>
public interface IReferencedEntity
    : IEntity {

    /// <summary>
    ///     Unique reference value.
    /// </summary>
    /// <remarks>
    ///     It's lenght must be strict 8.
    /// </remarks>
    [StringLength(8, MinimumLength = 8)]
    public string Reference { get; set; }
}

/// <summary>
///     Represents an <see cref="IEntity"/> with a <see cref="IReferencedEntity.Reference"/> unique property wich allows its identification along
///     data storages migrations as this property is absolute static.
/// </summary>
public abstract class BReferencedEntity
    : BEntity, IReferencedEntity {

    public string Reference { get; set; } = string.Empty;
}

/// <summary>
///     [Converter] concept implementation for complex data structures that are derived from <see cref="IEntity"/>, this converter manager must
///     be injected into the [JsonSerializerOptions] from you server implementation.
/// </summary>
public class EntityConverter
    : BConverter<IEntity> {

    public EntityConverter(Type[] variations)
        : base(variations) {

    }
}