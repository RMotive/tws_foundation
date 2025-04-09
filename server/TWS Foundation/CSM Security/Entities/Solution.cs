using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Validators;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Entity] that stores information for business environment solution.
/// </summary>
public class Solution
    : BEntity, INamedEntity {

    #region Properties

    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    /// <summary>
    ///     Solution unique sign to reference easyly the solution along operations.
    /// </summary>
    /// <remarks>
    ///     Must be unique along records. 5 Restricted Length.
    /// </remarks>
    public string Sign { get; set; } = string.Empty;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Permit"/> dependants from this <see cref="Solution"/>.
    /// </summary>
    public ICollection<Permit> Permits { get; set; } = [];

    #endregion

    protected override (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container) {
        Container = [
            ..Container,
            (nameof(Sign), [new UniqueValidator(), new LengthValidator(5, 5)]),
        ];
        return Container;
    }

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Sign)).IsFixedLength().HasMaxLength(5).IsRequired();
        etBuilder.HasIndex(nameof(Sign)).IsUnique();
    }
}
