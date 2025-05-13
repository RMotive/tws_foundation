using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores identification information for a physical being for business entities related information.
/// </summary>
public class Identification
    : BEntity {

    #region Properties

    /// <summary>
    ///     Legal name. 
    /// </summary>
    /// <remarks>
    ///     For more than one name split with double space.
    /// </remarks>
    [StringLength(100, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    /// <summary>
    ///     Legal first last name (father).
    /// </summary>
    /// <remarks>
    ///     For more than one name split with double space.
    /// </remarks>
    [StringLength(32, MinimumLength = 1)]
    public string Lastname { get; set; } = string.Empty;

    /// <summary>
    ///     Birthday.
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
        etBuilder.Property(nameof(Lastname)).HasMaxLength(32).IsRequired();
        etBuilder.Property(nameof(Name)).HasMaxLength(32).IsRequired();

        etBuilder.Link<Identification, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
