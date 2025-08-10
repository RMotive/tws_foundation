using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BEntity = TWS_Business.Bases.BEntity;

namespace TWS_Business.Entities.Insurances;

/// <summary>
///     [Entity] that stores information for Insurances, this insurances are applicable for insurable actives linke (<see cref="Truck"/> / <see cref="Trailer"/>).
/// </summary>
public class Insurance
    : BEntity {

    #region Properties

    /// <summary>
    ///     Insurance policy identifier.
    /// </summary>
    [StringLength(20, MinimumLength = 1)]
    public string Policy { get; set; } = string.Empty;

    /// <summary>
    ///     Contract country.
    /// </summary>
    [StringLength(3, MinimumLength = 2)]
    public string Country { get; set; } = string.Empty;

    /// <summary>
    ///     Insurance expiration date.
    /// </summary>
    public DateOnly Expiration { get; set; }

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

    #region Dependants

    /// <summary>
    ///     <see cref="Truck"/> dependants from this <see cref="Insurance"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    #endregion

    /// <summary>
    ///     History entries.
    /// </summary>
    public ICollection<Insurance_History> History { get; set; } = [];

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Country)).HasMaxLength(3);
        etBuilder.Property(nameof(Policy)).HasMaxLength(20);

        etBuilder.Link<Insurance, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
    }
}
