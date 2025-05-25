using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Entities;

/// <summary>
///     [History etBuilder] for <see cref="Approach"/> entity.
/// </summary>
public class Approach_History
    : TWSHistory<Approach> {

    #region Properties

    /// <summary>
    ///     Electronic mail address.
    /// </summary>
    [StringLength(64)]
    public string? EMail { get; set; } = string.Empty;

    /// <summary>
    ///     Enterprise phone number.
    /// </summary>
    [StringLength(13)]
    public string? Enterprise { get; set; }

    /// <summary>
    ///     Personal phone number.
    /// </summary>
    [StringLength(13)]
    public string? Personal { get; set; }

    /// <summary>
    ///     Alternative phone number
    /// </summary>
    [StringLength(13)]
    public string? Alternative { get; set; }

    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Carrier_History"/> entries dependants from this <see cref="Approach_History"/>.
    /// </summary>
    public ICollection<Carrier_History> CarriersHistories { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.ToTable("Approaches_Histories");

        etBuilder.Property(nameof(EMail)).HasMaxLength(64).IsRequired();
        etBuilder.Property(nameof(Enterprise)).HasMaxLength(13);
        etBuilder.Property(nameof(Personal)).HasMaxLength(13);
        etBuilder.Property(nameof(Alternative)).HasMaxLength(30);

        etBuilder.Link<Approach_History, Status>(
                nameof(Status),
                TargetReference: nameof(Status.ApproachesHistories),
                Required: true,
                Auto: true
            );
    }
}
