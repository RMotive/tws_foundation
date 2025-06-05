using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.USDOTs;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [Entity] that stores information about a carrying company.
/// </summary>
public class Carrier
    : BEntity, INamedEntity, IHistorical<Carrier_History> {

    #region Properties
    [StringLength(100)]
    public string Name { get; set; } = string.Empty;

    [StringLength(maximumLength: 200)]
    public string? Description { get; set; }

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

    /// <summary>
    ///     <see cref="Entities.Approach"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Approach Approach { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Address"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Address Address { get; set; } = default!;

    /// <summary>
    ///     <see cref="USDOTs.USDOT"/> information.
    /// </summary>
    [Relation]
    public USDOT? USDOT { get; set; }

    #endregion

    #region Dependants 

    /// <summary>
    ///     <see cref="Truck"/>s referencing this <see cref="Carrier"/>
    /// </summary>
    public ICollection<Truck> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer"/>s referencing this <see cref="Carrier"/>. 
    /// </summary>
    public ICollection<Trailer> Trailers { get; set; } = [];

    #endregion

    public ICollection<Carrier_History> History { get; set; } = [];

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Link<Carrier, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Carrier, Approach>(
                nameof(Approach),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Carrier, Address>(
                nameof(Address),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Carrier, USDOT>(nameof(USDOT));
    }
}
