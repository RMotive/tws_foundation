using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [Entity] that stores information about legal vehicule plates in own posession.
/// </summary>
public class Plate
    : BEntity {

    #region Properties

    /// <summary>
    ///     Plate identifier number.
    /// </summary>
    [StringLength(12, MinimumLength = 1)]
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
    [EntityRelation]
    public Status Status { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Trucks.Truck"/> information.
    /// </summary>
    [EntityRelation]
    public Truck? Truck { get; set; }

    /// <summary>
    ///     <see cref="Trailers.Trailer"/> information.
    /// </summary>
    [EntityRelation]
    public Trailer? Trailer { get; set; }

    #endregion

    /// <summary>
    ///     etBuilder history entries.
    /// </summary>
    public ICollection<Plate_History> History { get; set; } = [];

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(State)).HasMaxLength(3);
        etBuilder.Property(nameof(Country)).HasMaxLength(3);
        etBuilder.Property(nameof(Identifier)).HasMaxLength(12);

        etBuilder.Link<Plate, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );

        etBuilder.Link<Plate, Truck>(nameof(Truck));
        etBuilder.Link<Plate, Trailer>(nameof(Trailer));

    }
}
