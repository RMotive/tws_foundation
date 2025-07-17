using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores identification information for a physical being for business entities related information.
/// </summary>
public class Identification
    : BEntity {

    #region Properties

    /// <summary>
    ///     Physical person name. 
    /// </summary>
    /// <remarks>
    ///     For more than one name split with double space.
    /// </remarks>
    [StringLength(32, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    /// <summary>
    ///     Physical person name last name.
    /// </summary>
    /// <remarks>
    ///     For more than one name split with double space.
    /// </remarks>
    [StringLength(32, MinimumLength = 1)]
    public string LastName { get; set; } = string.Empty;

    /// <summary>
    ///     Person birth day.
    /// </summary>
    public DateOnly? Birthday { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Status Status { get; set; } = default!;

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(LastName)).HasMaxLength(32).IsRequired();
        etBuilder.Property(nameof(Name)).HasMaxLength(32).IsRequired();

        etBuilder.Link<Identification, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
