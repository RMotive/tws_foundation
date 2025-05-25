using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Entities;

/// <summary>
///     [Entity] that stores a spot that represents a business physical location.
/// </summary>
public class Location
    : BEntity, INamedEntity {

    #region Properties
    [StringLength(100, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    [StringLength(200, MinimumLength = 1)]
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
    ///     <see cref="Address"/> information.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    [Relation]
    public Address Address { get; set; } = default!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Section"/>s referencing this <see cref="Location"/>
    /// </summary>
    public ICollection<Section> Sections { get; set; } = [];

    /// <summary>
    ///     <see cref="Truck_Common"/>s referencing this <see cref="Location"/>
    /// </summary>
    public ICollection<Truck_Common> Trucks { get; set; } = [];

    /// <summary>
    ///     <see cref="Trailer_Common"/>s referencing this <see cref="Location"/>
    /// </summary>
    public ICollection<Trailer_Common> Trailers { get; set; } = [];

    /// <summary>
    ///     <see cref="Entities.Waypoint"/> dependant from this <see cref="Waypoint"/>.
    /// </summary>
    public Waypoint? Waypoint { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {

        etBuilder.Link<Location, Status>(
                nameof(Status),
                Required: true,
                Auto: true
            );
        etBuilder.Link<Location, Address>(
                nameof(Address),
                Required: true,
                Auto: true
            );
    }
}
