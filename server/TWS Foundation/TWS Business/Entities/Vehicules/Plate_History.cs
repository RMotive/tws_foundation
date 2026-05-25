using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [History Entity] for <see cref="Plate"/>
/// </summary>
public class Plate_History
    : BHistory<Plate> {

    #region Properties

    /// <summary>
    ///     Plate identifier number.
    /// </summary>
    public string Identifier { get; set; } = string.Empty;

    /// <summary>
    ///     Political country the plate is from.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string Country { get; set; } = string.Empty;

    /// <summary>
    ///     Political state name the plate is from.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string? State { get; set; }

    /// <summary>
    ///     Expiration date.
    /// </summary>
    public DateOnly? Expiration { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(State)).HasMaxLength(3);
        etBuilder.Property(nameof(Country)).HasMaxLength(3);
        etBuilder.Property(nameof(Identifier)).HasMaxLength(12);

        etBuilder.Link<Plate_History, Status>(
                nameof(Status),
                TargetReference: nameof(Status.PlatesHistories),
                Required: true,
                Auto: true
            );
    }
}
