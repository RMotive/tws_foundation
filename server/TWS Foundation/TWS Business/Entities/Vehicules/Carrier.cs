using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.USDOTs;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using BNamedEntity = TWS_Business.Bases.BNamedEntity;

namespace TWS_Business.Entities.Vehicules;

/// <summary>
///     [Entity] that stores information about a carrying company.
/// </summary>
public class Carrier
    : BNamedEntity {

    #region Relations

    /// <summary>
    ///     <see cref="Entities.Status"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Status", typeof(Status))]
    public Status Status { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Approach"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Approach", typeof(Approach))]
    public Approach Approach { get; set; } = default!;

    /// <summary>
    ///     <see cref="Entities.Address"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [EntityDependant("Address", typeof(Address))]
    public Address Address { get; set; } = default!;

    /// <summary>
    ///     <see cref="USDOTs.USDOT"/> information.
    /// </summary>
    [EntityDependant("USDOT", typeof(USDOT))]
    public USDOT? USDOT { get; set; }

    #endregion

    #region Dependants 

    /// <summary>
    ///     <see cref="Truck"/>s referencing this <see cref="Carrier"/>
    /// </summary>
    [EntityDependency("Trucks", typeof(Truck), isCollection:true)]
    public ICollection<Truck> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer"/>s referencing this <see cref="Carrier"/>. 
    /// </summary>
    [EntityDependency("Trailers", typeof(Trailer), isCollection:true)]
    public ICollection<Trailer> Trailers { get; set; } = [];

    #endregion

    [EntityDependency("History", typeof(Carrier_History), isCollection:true)]
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
